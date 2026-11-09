# frozen_string_literal: true

module Schematic
  module Customplangrouprollouts
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
      # @option params [String] :plan_id
      #
      # @example
      #   client.customplangrouprollouts.list_group_rollouts(plan_id: "plan_id")
      #
      # @return [Schematic::Customplangrouprollouts::Types::ListGroupRolloutsResponse]
      def list_group_rollouts(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "custom-plan-group-rollouts",
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
          (response.body.to_s.empty? ? nil : Schematic::Customplangrouprollouts::Types::ListGroupRolloutsResponse.load(response.body))
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          error_types = {
            400 => Schematic::Types::ApiError,
            401 => Schematic::Types::ApiError,
            403 => Schematic::Types::ApiError,
            404 => Schematic::Types::ApiError,
            500 => Schematic::Types::ApiError
          }
          error_body = Schematic::Errors::ResponseError.load_error_body(code, response.body, error_types)
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :custom_plan_group_rollout_id
      #
      # @example
      #   client.customplangrouprollouts.get_group_rollout(custom_plan_group_rollout_id: "custom_plan_group_rollout_id")
      #
      # @return [Schematic::Customplangrouprollouts::Types::GetGroupRolloutResponse]
      def get_group_rollout(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "custom-plan-group-rollouts/#{URI.encode_uri_component(params[:custom_plan_group_rollout_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          (response.body.to_s.empty? ? nil : Schematic::Customplangrouprollouts::Types::GetGroupRolloutResponse.load(response.body))
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          error_types = {
            401 => Schematic::Types::ApiError,
            403 => Schematic::Types::ApiError,
            404 => Schematic::Types::ApiError,
            500 => Schematic::Types::ApiError
          }
          error_body = Schematic::Errors::ResponseError.load_error_body(code, response.body, error_types)
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Customplangrouprollouts::Types::CopyCustomPlanRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      #
      # @example
      #   client.customplangrouprollouts.copy_custom_plan(
      #     plan_id: "plan_id",
      #     company_id: "company_id"
      #   )
      #
      # @return [Schematic::Customplangrouprollouts::Types::CopyCustomPlanResponse]
      def copy_custom_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Customplangrouprollouts::Types::CopyCustomPlanRequestBody.new(params).to_h
        non_body_param_names = %w[plan_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "custom-plans/#{URI.encode_uri_component(params[:plan_id].to_s)}/copies",
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
          (response.body.to_s.empty? ? nil : Schematic::Customplangrouprollouts::Types::CopyCustomPlanResponse.load(response.body))
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          error_types = {
            400 => Schematic::Types::ApiError,
            401 => Schematic::Types::ApiError,
            403 => Schematic::Types::ApiError,
            404 => Schematic::Types::ApiError,
            500 => Schematic::Types::ApiError
          }
          error_body = Schematic::Errors::ResponseError.load_error_body(code, response.body, error_types)
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
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
      # @option params [String, nil] :from_plan_version_id
      # @option params [String, nil] :to_plan_version_id
      #
      # @example
      #   client.customplangrouprollouts.preview_group_rollout(
      #     plan_id: "plan_id",
      #     from_plan_version_id: "from_plan_version_id",
      #     to_plan_version_id: "to_plan_version_id"
      #   )
      #
      # @return [Schematic::Customplangrouprollouts::Types::PreviewGroupRolloutResponse]
      def preview_group_rollout(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["from_plan_version_id"] = params[:from_plan_version_id] if params.key?(:from_plan_version_id)
        query_params["to_plan_version_id"] = params[:to_plan_version_id] if params.key?(:to_plan_version_id)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "custom-plans/#{URI.encode_uri_component(params[:plan_id].to_s)}/group-rollout-preview",
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
          (response.body.to_s.empty? ? nil : Schematic::Customplangrouprollouts::Types::PreviewGroupRolloutResponse.load(response.body))
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          error_types = {
            401 => Schematic::Types::ApiError,
            403 => Schematic::Types::ApiError,
            404 => Schematic::Types::ApiError,
            500 => Schematic::Types::ApiError
          }
          error_body = Schematic::Errors::ResponseError.load_error_body(code, response.body, error_types)
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Customplangrouprollouts::Types::StartGroupRolloutRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_id
      #
      # @example
      #   client.customplangrouprollouts.start_group_rollout(
      #     plan_id: "plan_id",
      #     excluded_company_ids: ["excluded_company_ids"]
      #   )
      #
      # @return [Schematic::Customplangrouprollouts::Types::StartGroupRolloutResponse]
      def start_group_rollout(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Customplangrouprollouts::Types::StartGroupRolloutRequestBody.new(params).to_h
        non_body_param_names = %w[plan_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "custom-plans/#{URI.encode_uri_component(params[:plan_id].to_s)}/group-rollouts",
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
          (response.body.to_s.empty? ? nil : Schematic::Customplangrouprollouts::Types::StartGroupRolloutResponse.load(response.body))
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          error_types = {
            400 => Schematic::Types::ApiError,
            401 => Schematic::Types::ApiError,
            403 => Schematic::Types::ApiError,
            404 => Schematic::Types::ApiError,
            500 => Schematic::Types::ApiError
          }
          error_body = Schematic::Errors::ResponseError.load_error_body(code, response.body, error_types)
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end
    end
  end
end
