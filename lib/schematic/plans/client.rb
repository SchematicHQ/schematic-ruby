# frozen_string_literal: true

module Schematic
  module Plans
    class Client
      # @param client [Schematic::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plans::Types::UpdateCompanyPlansRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :company_id
      #
      # @example
      #   client.plans.update_company_plans(
      #     company_id: "company_id",
      #     add_on_ids: ["add_on_ids"]
      #   )
      #
      # @return [Schematic::Plans::Types::UpdateCompanyPlansResponse]
      def update_company_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plans::Types::UpdateCompanyPlansRequestBody.new(params).to_h
        non_body_param_names = %w[company_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "company-plans/#{URI.encode_uri_component(params[:company_id].to_s)}",
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
          Schematic::Plans::Types::UpdateCompanyPlansResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :company_id
      # @option params [String, nil] :plan_id
      # @option params [Schematic::Types::PlanBillingSource, nil] :plan_billing_source
      # @option params [Schematic::Types::CustomPlanBillingStatus, nil] :status
      # @option params [Schematic::Types::CustomPlanBillingStatus, nil] :statuses
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.plans.list_custom_plan_billings(
      #     company_id: "company_id",
      #     plan_id: "plan_id",
      #     plan_billing_source: "custom_plan",
      #     status: "active",
      #     statuses: ["active"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Plans::Types::ListCustomPlanBillingsResponse]
      def list_custom_plan_billings(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_billing_source"] = params[:plan_billing_source] if params.key?(:plan_billing_source)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["statuses"] = params[:statuses] if params.key?(:statuses)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "custom-plan-billings",
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
          Schematic::Plans::Types::ListCustomPlanBillingsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::MarkCustomPlanBillingPaidRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :custom_plan_billing_id
      #
      # @example
      #   client.plans.mark_custom_plan_billing_paid(
      #     custom_plan_billing_id: "custom_plan_billing_id",
      #     request: {
      #       key: "value"
      #     }
      #   )
      #
      # @return [Schematic::Plans::Types::MarkCustomPlanBillingPaidResponse]
      def mark_custom_plan_billing_paid(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[custom_plan_billing_id]
        body_params = params.except(*path_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "custom-plan-billings/#{URI.encode_uri_component(params[:custom_plan_billing_id].to_s)}/mark-paid",
          body: body_params,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::MarkCustomPlanBillingPaidResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plans::Types::RetryCustomPlanBillingRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :custom_plan_billing_id
      #
      # @example
      #   client.plans.retry_custom_plan_billing(
      #     custom_plan_billing_id: "custom_plan_billing_id",
      #     customer_email: "customer_email"
      #   )
      #
      # @return [Schematic::Plans::Types::RetryCustomPlanBillingResponse]
      def retry_custom_plan_billing(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plans::Types::RetryCustomPlanBillingRequestBody.new(params).to_h
        non_body_param_names = %w[custom_plan_billing_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "custom-plan-billings/#{URI.encode_uri_component(params[:custom_plan_billing_id].to_s)}/retry",
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
          Schematic::Plans::Types::RetryCustomPlanBillingResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plans::Types::CreateCustomPlanRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.plans.create_custom_plan(
      #     company_id: "company_id",
      #     name: "name"
      #   )
      #
      # @return [Schematic::Plans::Types::CreateCustomPlanResponse]
      def create_custom_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "custom-plans",
          body: Schematic::Plans::Types::CreateCustomPlanRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::CreateCustomPlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :company_id
      # @option params [Boolean, nil] :company_scoped_only
      # @option params [Boolean, nil] :exclude_company_scoped
      # @option params [Boolean, nil] :for_fallback_plan
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [Boolean, nil] :has_product_id
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :include_draft_versions
      # @option params [Schematic::Types::PlanType, nil] :plan_type
      # @option params [String, nil] :q
      # @option params [String, nil] :scoped_to_company_id
      # @option params [Boolean, nil] :with_entitlements
      # @option params [String, nil] :without_entitlement_for
      # @option params [Boolean, nil] :without_paid_product_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.plans.list_plans(
      #     company_id: "company_id",
      #     company_scoped_only: true,
      #     exclude_company_scoped: true,
      #     for_fallback_plan: true,
      #     for_initial_plan: true,
      #     for_trial_expiry_plan: true,
      #     has_product_id: true,
      #     ids: ["ids"],
      #     include_draft_versions: true,
      #     plan_type: "plan",
      #     q: "q",
      #     scoped_to_company_id: "scoped_to_company_id",
      #     with_entitlements: true,
      #     without_entitlement_for: "without_entitlement_for",
      #     without_paid_product_id: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Plans::Types::ListPlansResponse]
      def list_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_scoped_only"] = params[:company_scoped_only] if params.key?(:company_scoped_only)
        query_params["exclude_company_scoped"] = params[:exclude_company_scoped] if params.key?(:exclude_company_scoped)
        query_params["for_fallback_plan"] = params[:for_fallback_plan] if params.key?(:for_fallback_plan)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["has_product_id"] = params[:has_product_id] if params.key?(:has_product_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["include_draft_versions"] = params[:include_draft_versions] if params.key?(:include_draft_versions)
        query_params["plan_type"] = params[:plan_type] if params.key?(:plan_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["scoped_to_company_id"] = params[:scoped_to_company_id] if params.key?(:scoped_to_company_id)
        query_params["with_entitlements"] = params[:with_entitlements] if params.key?(:with_entitlements)
        query_params["without_entitlement_for"] = params[:without_entitlement_for] if params.key?(:without_entitlement_for)
        query_params["without_paid_product_id"] = params[:without_paid_product_id] if params.key?(:without_paid_product_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans",
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
          Schematic::Plans::Types::ListPlansResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::CreatePlanRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.plans.create_plan(
      #     name: "name",
      #     plan_type: "plan"
      #   )
      #
      # @return [Schematic::Plans::Types::CreatePlanResponse]
      def create_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "plans",
          body: Schematic::Types::CreatePlanRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::CreatePlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      # @option params [String, nil] :plan_version_id
      #
      # @example
      #   client.plans.get_plan(
      #     plan_id: "plan_id",
      #     plan_version_id: "plan_version_id"
      #   )
      #
      # @return [Schematic::Plans::Types::GetPlanResponse]
      def get_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}",
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
          Schematic::Plans::Types::GetPlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::UpdatePlanRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      #
      # @example
      #   client.plans.update_plan(
      #     plan_id: "plan_id",
      #     name: "name"
      #   )
      #
      # @return [Schematic::Plans::Types::UpdatePlanResponse]
      def update_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[plan_id]
        body_params = params.except(*path_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}",
          body: Schematic::Types::UpdatePlanRequestBody.new(body_params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::UpdatePlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      #
      # @example
      #   client.plans.delete_plan(plan_id: "plan_id")
      #
      # @return [Schematic::Plans::Types::DeletePlanResponse]
      def delete_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::DeletePlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::UpsertBillingProductRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      #
      # @example
      #   client.plans.upsert_billing_product_plan(
      #     plan_id: "plan_id",
      #     charge_type: "free",
      #     is_trialable: true
      #   )
      #
      # @return [Schematic::Plans::Types::UpsertBillingProductPlanResponse]
      def upsert_billing_product_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[plan_id]
        body_params = params.except(*path_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}/billing_products",
          body: Schematic::Types::UpsertBillingProductRequestBody.new(body_params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::UpsertBillingProductPlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plans::Types::CreateBillingLinkedPlanRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.plans.upsert_plan_for_billing_product(
      #     billing_provider: "metronome",
      #     external_resource_id: "external_resource_id",
      #     name: "name",
      #     plan_type: "plan"
      #   )
      #
      # @return [Schematic::Plans::Types::UpsertPlanForBillingProductResponse]
      def upsert_plan_for_billing_product(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "plans/billing-linked",
          body: Schematic::Plans::Types::CreateBillingLinkedPlanRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Plans::Types::UpsertPlanForBillingProductResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.plans.list_billing_product_match_companies(
      #     plan_id: "plan_id",
      #     q: "q",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Plans::Types::ListBillingProductMatchCompaniesResponse]
      def list_billing_product_match_companies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans/billing-product-match-companies",
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
          Schematic::Plans::Types::ListBillingProductMatchCompaniesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.plans.count_billing_product_match_companies(
      #     plan_id: "plan_id",
      #     q: "q",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Plans::Types::CountBillingProductMatchCompaniesResponse]
      def count_billing_product_match_companies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans/billing-product-match-companies/count",
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
          Schematic::Plans::Types::CountBillingProductMatchCompaniesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :company_id
      # @option params [Boolean, nil] :company_scoped_only
      # @option params [Boolean, nil] :exclude_company_scoped
      # @option params [Boolean, nil] :for_fallback_plan
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [Boolean, nil] :has_product_id
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :include_draft_versions
      # @option params [Schematic::Types::PlanType, nil] :plan_type
      # @option params [String, nil] :q
      # @option params [String, nil] :scoped_to_company_id
      # @option params [Boolean, nil] :with_entitlements
      # @option params [String, nil] :without_entitlement_for
      # @option params [Boolean, nil] :without_paid_product_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.plans.count_plans(
      #     company_id: "company_id",
      #     company_scoped_only: true,
      #     exclude_company_scoped: true,
      #     for_fallback_plan: true,
      #     for_initial_plan: true,
      #     for_trial_expiry_plan: true,
      #     has_product_id: true,
      #     ids: ["ids"],
      #     include_draft_versions: true,
      #     plan_type: "plan",
      #     q: "q",
      #     scoped_to_company_id: "scoped_to_company_id",
      #     with_entitlements: true,
      #     without_entitlement_for: "without_entitlement_for",
      #     without_paid_product_id: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Plans::Types::CountPlansResponse]
      def count_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_scoped_only"] = params[:company_scoped_only] if params.key?(:company_scoped_only)
        query_params["exclude_company_scoped"] = params[:exclude_company_scoped] if params.key?(:exclude_company_scoped)
        query_params["for_fallback_plan"] = params[:for_fallback_plan] if params.key?(:for_fallback_plan)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["has_product_id"] = params[:has_product_id] if params.key?(:has_product_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["include_draft_versions"] = params[:include_draft_versions] if params.key?(:include_draft_versions)
        query_params["plan_type"] = params[:plan_type] if params.key?(:plan_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["scoped_to_company_id"] = params[:scoped_to_company_id] if params.key?(:scoped_to_company_id)
        query_params["with_entitlements"] = params[:with_entitlements] if params.key?(:with_entitlements)
        query_params["without_entitlement_for"] = params[:without_entitlement_for] if params.key?(:without_entitlement_for)
        query_params["without_paid_product_id"] = params[:without_paid_product_id] if params.key?(:without_paid_product_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans/count",
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
          Schematic::Plans::Types::CountPlansResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      # @option params [String, nil] :plan_version_id
      #
      # @example
      #   client.plans.list_plan_issues(
      #     plan_id: "plan_id",
      #     plan_version_id: "plan_version_id"
      #   )
      #
      # @return [Schematic::Plans::Types::ListPlanIssuesResponse]
      def list_plan_issues(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plans/issues",
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
          Schematic::Plans::Types::ListPlanIssuesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_version_id
      # @option params [Boolean, nil] :promote_archived_version
      #
      # @example
      #   client.plans.delete_plan_version(
      #     plan_version_id: "plan_version_id",
      #     promote_archived_version: true
      #   )
      #
      # @return [Schematic::Plans::Types::DeletePlanVersionResponse]
      def delete_plan_version(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["promote_archived_version"] = params[:promote_archived_version] if params.key?(:promote_archived_version)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "plans/version/#{URI.encode_uri_component(params[:plan_version_id].to_s)}",
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
          Schematic::Plans::Types::DeletePlanVersionResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Plans::Types::PublishPlanVersionRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_version_id
      #
      # @example
      #   client.plans.publish_plan_version(
      #     plan_version_id: "plan_version_id",
      #     excluded_company_ids: ["excluded_company_ids"],
      #     migration_strategy: "immediate"
      #   )
      #
      # @return [Schematic::Plans::Types::PublishPlanVersionResponse]
      def publish_plan_version(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plans::Types::PublishPlanVersionRequestBody.new(params).to_h
        non_body_param_names = %w[plan_version_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/version/#{URI.encode_uri_component(params[:plan_version_id].to_s)}/publish",
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
          Schematic::Plans::Types::PublishPlanVersionResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
