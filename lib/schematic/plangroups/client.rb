# frozen_string_literal: true

module Schematic
  module Plangroups
    class Client
      # @param client [Schematic::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [Boolean, nil] :include_company_counts
      #
      # @example
      #   client.plangroups.get_plan_group(include_company_counts: true)
      #
      # @return [Schematic::Plangroups::Types::GetPlanGroupResponse]
      def get_plan_group(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["include_company_counts"] = params[:include_company_counts] if params.key?(:include_company_counts)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-groups",
          query: query_params,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plangroups::Types::GetPlanGroupResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plangroups::Types::CreatePlanGroupRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.plangroups.create_plan_group(
      #     add_on_ids: ["add_on_ids"],
      #     checkout_collect_address: true,
      #     checkout_collect_email: true,
      #     checkout_collect_phone: true,
      #     checkout_collect_tax_id: true,
      #     enable_tax_collection: true,
      #     opt_in_enabled: true,
      #     ordered_add_ons: [{
      #       plan_id: "plan_id"
      #     }],
      #     ordered_bundle_list: [{
      #       bundle_id: "bundleId"
      #     }],
      #     ordered_plans: [{
      #       plan_id: "plan_id"
      #     }],
      #     prevent_downgrades_when_over_limit: true,
      #     prevent_self_service_downgrade: true,
      #     proration_behavior: "create_prorations",
      #     show_as_monthly_prices: true,
      #     show_credits: true,
      #     show_feature_description: true,
      #     show_hard_limit: true,
      #     show_period_toggle: true,
      #     show_zero_price_as_free: true,
      #     sync_customer_billing_details: true
      #   )
      #
      # @return [Schematic::Plangroups::Types::CreatePlanGroupResponse]
      def create_plan_group(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "plan-groups",
          body: Schematic::Plangroups::Types::CreatePlanGroupRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plangroups::Types::CreatePlanGroupResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plangroups::Types::UpdatePlanGroupRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_group_id
      #
      # @example
      #   client.plangroups.update_plan_group(
      #     plan_group_id: "plan_group_id",
      #     add_on_ids: ["add_on_ids"],
      #     checkout_collect_address: true,
      #     checkout_collect_email: true,
      #     checkout_collect_phone: true,
      #     checkout_collect_tax_id: true,
      #     enable_tax_collection: true,
      #     opt_in_enabled: true,
      #     ordered_add_ons: [{
      #       plan_id: "plan_id"
      #     }],
      #     ordered_bundle_list: [{
      #       bundle_id: "bundleId"
      #     }],
      #     ordered_plans: [{
      #       plan_id: "plan_id"
      #     }],
      #     prevent_downgrades_when_over_limit: true,
      #     prevent_self_service_downgrade: true,
      #     proration_behavior: "create_prorations",
      #     show_as_monthly_prices: true,
      #     show_credits: true,
      #     show_feature_description: true,
      #     show_hard_limit: true,
      #     show_period_toggle: true,
      #     show_zero_price_as_free: true,
      #     sync_customer_billing_details: true
      #   )
      #
      # @return [Schematic::Plangroups::Types::UpdatePlanGroupResponse]
      def update_plan_group(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plangroups::Types::UpdatePlanGroupRequestBody.new(params).to_h
        non_body_param_names = %w[plan_group_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plan-groups/#{URI.encode_uri_component(params[:plan_group_id].to_s)}",
          body: body,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plangroups::Types::UpdatePlanGroupResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
