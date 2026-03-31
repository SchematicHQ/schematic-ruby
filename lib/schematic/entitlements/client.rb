# frozen_string_literal: true

module Schematic
  module Entitlements
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
      # @option params [String, nil] :company_id
      # @option params [String, nil] :company_ids
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :without_expired
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::ListCompanyOverridesResponse]
      def list_company_overrides(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id company_ids feature_id feature_ids ids without_expired q limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["without_expired"] = params[:without_expired] if params.key?(:without_expired)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "company-overrides",
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
          Schematic::Entitlements::Types::ListCompanyOverridesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Entitlements::Types::CreateCompanyOverrideRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Entitlements::Types::CreateCompanyOverrideResponse]
      def create_company_override(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "company-overrides",
          body: Schematic::Entitlements::Types::CreateCompanyOverrideRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::CreateCompanyOverrideResponse.load(response.body)
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
      # @option params [String] :company_override_id
      #
      # @return [Schematic::Entitlements::Types::GetCompanyOverrideResponse]
      def get_company_override(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "company-overrides/#{URI.encode_uri_component(params[:company_override_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::GetCompanyOverrideResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Entitlements::Types::UpdateCompanyOverrideRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :company_override_id
      #
      # @return [Schematic::Entitlements::Types::UpdateCompanyOverrideResponse]
      def update_company_override(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Entitlements::Types::UpdateCompanyOverrideRequestBody.new(params).to_h
        non_body_param_names = ["company_override_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "company-overrides/#{URI.encode_uri_component(params[:company_override_id].to_s)}",
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
          Schematic::Entitlements::Types::UpdateCompanyOverrideResponse.load(response.body)
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
      # @option params [String] :company_override_id
      #
      # @return [Schematic::Entitlements::Types::DeleteCompanyOverrideResponse]
      def delete_company_override(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "company-overrides/#{URI.encode_uri_component(params[:company_override_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::DeleteCompanyOverrideResponse.load(response.body)
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
      # @option params [String, nil] :company_ids
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [Boolean, nil] :without_expired
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::CountCompanyOverridesResponse]
      def count_company_overrides(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id company_ids feature_id feature_ids ids without_expired q limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["without_expired"] = params[:without_expired] if params.key?(:without_expired)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "company-overrides/count",
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
          Schematic::Entitlements::Types::CountCompanyOverridesResponse.load(response.body)
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
      # @option params [String] :feature_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::ListFeatureCompaniesResponse]
      def list_feature_companies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id q limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-companies",
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
          Schematic::Entitlements::Types::ListFeatureCompaniesResponse.load(response.body)
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
      # @option params [String] :feature_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::CountFeatureCompaniesResponse]
      def count_feature_companies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id q limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-companies/count",
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
          Schematic::Entitlements::Types::CountFeatureCompaniesResponse.load(response.body)
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
      # @option params [Hash[String, String], nil] :company_keys
      # @option params [String, nil] :feature_ids
      # @option params [Boolean, nil] :include_usage_aggregation
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :without_negative_entitlements
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::ListFeatureUsageResponse]
      def list_feature_usage(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id company_keys feature_ids include_usage_aggregation q without_negative_entitlements limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_keys"] = params[:company_keys] if params.key?(:company_keys)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["include_usage_aggregation"] = params[:include_usage_aggregation] if params.key?(:include_usage_aggregation)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["without_negative_entitlements"] = params[:without_negative_entitlements] if params.key?(:without_negative_entitlements)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-usage",
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
          Schematic::Entitlements::Types::ListFeatureUsageResponse.load(response.body)
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
      # @option params [String] :company_id
      # @option params [String] :end_time
      # @option params [String] :feature_id
      # @option params [Schematic::Types::TimeSeriesGranularity, nil] :granularity
      # @option params [String] :start_time
      #
      # @return [Schematic::Entitlements::Types::GetFeatureUsageTimeSeriesResponse]
      def get_feature_usage_time_series(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id end_time feature_id granularity start_time]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["granularity"] = params[:granularity] if params.key?(:granularity)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-usage-timeseries",
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
          Schematic::Entitlements::Types::GetFeatureUsageTimeSeriesResponse.load(response.body)
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
      # @option params [Hash[String, String], nil] :company_keys
      # @option params [String, nil] :feature_ids
      # @option params [Boolean, nil] :include_usage_aggregation
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :without_negative_entitlements
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::CountFeatureUsageResponse]
      def count_feature_usage(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id company_keys feature_ids include_usage_aggregation q without_negative_entitlements limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["company_keys"] = params[:company_keys] if params.key?(:company_keys)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["include_usage_aggregation"] = params[:include_usage_aggregation] if params.key?(:include_usage_aggregation)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["without_negative_entitlements"] = params[:without_negative_entitlements] if params.key?(:without_negative_entitlements)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-usage/count",
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
          Schematic::Entitlements::Types::CountFeatureUsageResponse.load(response.body)
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
      # @option params [String] :feature_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::ListFeatureUsersResponse]
      def list_feature_users(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id q limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-users",
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
          Schematic::Entitlements::Types::ListFeatureUsersResponse.load(response.body)
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
      # @option params [String] :feature_id
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::CountFeatureUsersResponse]
      def count_feature_users(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id q limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "feature-users/count",
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
          Schematic::Entitlements::Types::CountFeatureUsersResponse.load(response.body)
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
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [String, nil] :plan_id
      # @option params [String, nil] :plan_ids
      # @option params [String, nil] :plan_version_id
      # @option params [String, nil] :plan_version_ids
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :with_metered_products
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::ListPlanEntitlementsResponse]
      def list_plan_entitlements(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id feature_ids ids plan_id plan_ids plan_version_id plan_version_ids q with_metered_products limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["plan_version_ids"] = params[:plan_version_ids] if params.key?(:plan_version_ids)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["with_metered_products"] = params[:with_metered_products] if params.key?(:with_metered_products)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-entitlements",
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
          Schematic::Entitlements::Types::ListPlanEntitlementsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Entitlements::Types::CreatePlanEntitlementRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Entitlements::Types::CreatePlanEntitlementResponse]
      def create_plan_entitlement(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "plan-entitlements",
          body: Schematic::Entitlements::Types::CreatePlanEntitlementRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::CreatePlanEntitlementResponse.load(response.body)
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
      # @option params [String] :plan_entitlement_id
      #
      # @return [Schematic::Entitlements::Types::GetPlanEntitlementResponse]
      def get_plan_entitlement(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-entitlements/#{URI.encode_uri_component(params[:plan_entitlement_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::GetPlanEntitlementResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Entitlements::Types::UpdatePlanEntitlementRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_entitlement_id
      #
      # @return [Schematic::Entitlements::Types::UpdatePlanEntitlementResponse]
      def update_plan_entitlement(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Entitlements::Types::UpdatePlanEntitlementRequestBody.new(params).to_h
        non_body_param_names = ["plan_entitlement_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "plan-entitlements/#{URI.encode_uri_component(params[:plan_entitlement_id].to_s)}",
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
          Schematic::Entitlements::Types::UpdatePlanEntitlementResponse.load(response.body)
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
      # @option params [String] :plan_entitlement_id
      #
      # @return [Schematic::Entitlements::Types::DeletePlanEntitlementResponse]
      def delete_plan_entitlement(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "plan-entitlements/#{URI.encode_uri_component(params[:plan_entitlement_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::DeletePlanEntitlementResponse.load(response.body)
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
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [String, nil] :plan_id
      # @option params [String, nil] :plan_ids
      # @option params [String, nil] :plan_version_id
      # @option params [String, nil] :plan_version_ids
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :with_metered_products
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Entitlements::Types::CountPlanEntitlementsResponse]
      def count_plan_entitlements(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[feature_id feature_ids ids plan_id plan_ids plan_version_id plan_version_ids q with_metered_products limit offset]
        query_params = {}
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["plan_version_ids"] = params[:plan_version_ids] if params.key?(:plan_version_ids)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["with_metered_products"] = params[:with_metered_products] if params.key?(:with_metered_products)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-entitlements/count",
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
          Schematic::Entitlements::Types::CountPlanEntitlementsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Entitlements::Types::DuplicatePlanEntitlementsRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Entitlements::Types::DuplicatePlanEntitlementsResponse]
      def duplicate_plan_entitlements(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "plan-entitlements/duplicate",
          body: Schematic::Entitlements::Types::DuplicatePlanEntitlementsRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Entitlements::Types::DuplicatePlanEntitlementsResponse.load(response.body)
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
      # @option params [Hash[String, String]] :keys
      #
      # @return [Schematic::Entitlements::Types::GetFeatureUsageByCompanyResponse]
      def get_feature_usage_by_company(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[keys]
        query_params = {}
        query_params["keys"] = params[:keys] if params.key?(:keys)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "usage-by-company",
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
          Schematic::Entitlements::Types::GetFeatureUsageByCompanyResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
