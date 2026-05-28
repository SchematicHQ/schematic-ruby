# frozen_string_literal: true

require "json"

module Schematic
  module DataStream
    module Merge
      module_function

      def deep_copy(obj)
        JSON.parse(JSON.generate(obj), symbolize_names: true)
      rescue StandardError
        obj.dup
      end

      COMPANY_MAP_FIELDS = %i[credit_balances keys traits].freeze
      COMPANY_ARRAY_FIELDS = %i[billing_product_ids entitlements plan_ids plan_version_ids rules].freeze

      # Partials don't carry refreshed entitlements, so when their derived
      # fields change in another part of the company we sync them here to match
      # server behavior (see schematic-python merge.partial_company):
      #   - credit_remaining <- credit_balances[credit_id]
      #   - usage            <- metric value matching (event_name, metric_period, month_reset)
      # Both are skipped when the partial also sends entitlements wholesale.
      def partial_company(existing, partial_data)
        return existing unless partial_data.is_a?(Hash)

        result = deep_copy(existing)
        entitlements_in_partial = partial_data.key?(:entitlements) || partial_data.key?("entitlements")
        updated_balances = nil
        metrics_updated = false

        partial_data.each do |key, value|
          sym_key = key.to_sym
          if COMPANY_MAP_FIELDS.include?(sym_key)
            result[sym_key] ||= {}
            result[sym_key] = result[sym_key].merge(value) if value.is_a?(Hash)
            updated_balances = (value.is_a?(Hash) ? value : {}) if sym_key == :credit_balances
          elsif COMPANY_ARRAY_FIELDS.include?(sym_key)
            result[sym_key] = value if value.is_a?(Array)
          elsif sym_key == :metrics
            result[sym_key] = upsert_metrics(result[sym_key] || [], value || [])
            metrics_updated = true
          else
            result[sym_key] = value
          end
        end

        if (updated_balances&.any? || metrics_updated) && !entitlements_in_partial
          result[:entitlements] = sync_entitlements(
            result[:entitlements], result[:metrics], updated_balances, metrics_updated
          )
        end

        result
      end

      USER_MAP_FIELDS = %i[keys traits].freeze

      def partial_user(existing, partial_data)
        return existing unless partial_data.is_a?(Hash)

        result = deep_copy(existing)

        partial_data.each do |key, value|
          sym_key = key.to_sym
          if USER_MAP_FIELDS.include?(sym_key)
            result[sym_key] ||= {}
            result[sym_key] = result[sym_key].merge(value) if value.is_a?(Hash)
          elsif sym_key == :rules
            result[sym_key] = value if value.is_a?(Array)
          else
            result[sym_key] = value
          end
        end

        result
      end

      def upsert_metrics(existing, incoming)
        return incoming if existing.nil? || existing.empty?
        return existing if incoming.nil? || incoming.empty?

        result = existing.map { |metric| deep_copy(metric) }

        incoming.each do |inc_metric|
          match_idx = result.index do |ex|
            metrics_match?(ex, inc_metric)
          end

          if match_idx
            result[match_idx] = inc_metric
          else
            result << inc_metric
          end
        end

        result
      end

      def metrics_match?(left, right)
        get_metric_field(left, :event_subtype) == get_metric_field(right, :event_subtype) &&
          get_metric_field(left, :period) == get_metric_field(right, :period) &&
          get_metric_field(left, :month_reset) == get_metric_field(right, :month_reset)
      end

      def get_metric_field(metric, field)
        metric[field] || metric[field.to_s]
      end

      # Re-derive entitlement usage / credit_remaining from the merged metrics
      # and the just-updated credit balances. Mirrors schematic-python so that
      # entitlement usage reflects DataStream track events immediately.
      def sync_entitlements(entitlements, metrics, updated_balances, metrics_updated)
        return entitlements unless entitlements.is_a?(Array) && !entitlements.empty?

        metrics_lookup = {}
        if metrics_updated && metrics.is_a?(Array)
          metrics.each do |metric|
            next unless metric.is_a?(Hash)

            key = [
              get_metric_field(metric, :event_subtype) || "",
              get_metric_field(metric, :period) || "",
              get_metric_field(metric, :month_reset) || ""
            ]
            value = get_metric_field(metric, :value)
            metrics_lookup[key] = value.nil? ? 0 : value
          end
        end

        entitlements.map do |ent|
          next ent unless ent.is_a?(Hash)

          new_ent = deep_copy(ent)

          credit_id = get_metric_field(ent, :credit_id)
          if updated_balances && credit_id
            present, balance = fetch_balance(updated_balances, credit_id)
            new_ent[:credit_remaining] = balance if present
          end

          event_name = get_metric_field(ent, :event_name)
          unless metrics_lookup.empty? || event_name.nil?
            period = get_metric_field(ent, :metric_period) || "all_time"
            month_reset = get_metric_field(ent, :month_reset) || "first_of_month"
            matched = metrics_lookup[[event_name, period, month_reset]]
            new_ent[:usage] = matched unless matched.nil?
          end

          new_ent
        end
      end

      # The partial's credit_balances may be keyed by string or symbol depending
      # on how the message was parsed, while an entitlement's credit_id is a
      # string value, so check both key forms.
      def fetch_balance(balances, credit_id)
        return [true, balances[credit_id]] if balances.key?(credit_id)
        return [true, balances[credit_id.to_sym]] if balances.key?(credit_id.to_sym)

        [false, nil]
      end
    end
  end
end
