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
      # @option params [String] :company_plan_id
      #
      # @return [Schematic::Plans::Types::UpdateCompanyPlansResponse]
      def update_company_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plans::Types::UpdateCompanyPlansRequestBody.new(params).to_h
        non_body_param_names = ["company_plan_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "company-plans/#{URI.encode_uri_component(params[:company_plan_id].to_s)}",
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
      # @option params [Boolean, nil] :for_fallback_plan
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [Boolean, nil] :has_product_id
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :include_draft_versions
      # @option params [Schematic::Types::PlanType, nil] :plan_type
      # @option params [String, nil] :q
      # @option params [String, nil] :without_entitlement_for
      # @option params [Boolean, nil] :without_paid_product_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Plans::Types::ListPlansResponse]
      def list_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id for_fallback_plan for_initial_plan for_trial_expiry_plan has_product_id ids include_draft_versions plan_type q without_entitlement_for without_paid_product_id limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["for_fallback_plan"] = params[:for_fallback_plan] if params.key?(:for_fallback_plan)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["has_product_id"] = params[:has_product_id] if params.key?(:has_product_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["include_draft_versions"] = params[:include_draft_versions] if params.key?(:include_draft_versions)
        query_params["plan_type"] = params[:plan_type] if params.key?(:plan_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["without_entitlement_for"] = params[:without_entitlement_for] if params.key?(:without_entitlement_for)
        query_params["without_paid_product_id"] = params[:without_paid_product_id] if params.key?(:without_paid_product_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

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
      # @return [Schematic::Plans::Types::GetPlanResponse]
      def get_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[plan_version_id]
        query_params = {}
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        params = params.except(*query_param_names)

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
      # @return [Schematic::Plans::Types::UpdatePlanResponse]
      def update_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}",
          body: Schematic::Types::UpdatePlanRequestBody.new(params).to_h,
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
      # @return [Schematic::Plans::Types::UpsertBillingProductPlanResponse]
      def upsert_billing_product_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/#{URI.encode_uri_component(params[:plan_id].to_s)}/billing_products",
          body: Schematic::Types::UpsertBillingProductRequestBody.new(params).to_h,
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
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :company_id
      # @option params [Boolean, nil] :for_fallback_plan
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [Boolean, nil] :has_product_id
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :include_draft_versions
      # @option params [Schematic::Types::PlanType, nil] :plan_type
      # @option params [String, nil] :q
      # @option params [String, nil] :without_entitlement_for
      # @option params [Boolean, nil] :without_paid_product_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Plans::Types::CountPlansResponse]
      def count_plans(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id for_fallback_plan for_initial_plan for_trial_expiry_plan has_product_id ids include_draft_versions plan_type q without_entitlement_for without_paid_product_id limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["for_fallback_plan"] = params[:for_fallback_plan] if params.key?(:for_fallback_plan)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["has_product_id"] = params[:has_product_id] if params.key?(:has_product_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["include_draft_versions"] = params[:include_draft_versions] if params.key?(:include_draft_versions)
        query_params["plan_type"] = params[:plan_type] if params.key?(:plan_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["without_entitlement_for"] = params[:without_entitlement_for] if params.key?(:without_entitlement_for)
        query_params["without_paid_product_id"] = params[:without_paid_product_id] if params.key?(:without_paid_product_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

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
      # @return [Schematic::Plans::Types::ListPlanIssuesResponse]
      def list_plan_issues(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[plan_id plan_version_id]
        query_params = {}
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        params.except(*query_param_names)

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
      # @option params [String] :plan_id
      #
      # @return [Schematic::Plans::Types::DeletePlanVersionResponse]
      def delete_plan_version(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "plans/version/#{URI.encode_uri_component(params[:plan_id].to_s)}",
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
      # @option params [String] :plan_id
      #
      # @return [Schematic::Plans::Types::PublishPlanVersionResponse]
      def publish_plan_version(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Plans::Types::PublishPlanVersionRequestBody.new(params).to_h
        non_body_param_names = ["plan_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plans/version/#{URI.encode_uri_component(params[:plan_id].to_s)}/publish",
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
