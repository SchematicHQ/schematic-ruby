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

      def partial_company(existing, partial_data)
        return existing unless partial_data.is_a?(Hash)

        result = deep_copy(existing)

        partial_data.each do |key, value|
          sym_key = key.to_sym
          if COMPANY_MAP_FIELDS.include?(sym_key)
            result[sym_key] ||= {}
            result[sym_key] = result[sym_key].merge(value) if value.is_a?(Hash)
          elsif COMPANY_ARRAY_FIELDS.include?(sym_key)
            result[sym_key] = value if value.is_a?(Array)
          elsif sym_key == :metrics
            result[sym_key] = upsert_metrics(result[sym_key] || [], value || [])
          else
            result[sym_key] = value
          end
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
    end
  end
end
