# frozen_string_literal: true

module Schematic
  module Accounts
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
      # @option params [String, nil] :ids
      # @option params [String, nil] :q
      # @option params [Schematic::Types::AccountMemberRole, nil] :role
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.list_account_members(
      #     ids: ["ids"],
      #     q: "q",
      #     role: "admin",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::ListAccountMembersResponse]
      def list_account_members(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["role"] = params[:role] if params.key?(:role)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "account-members",
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
          Schematic::Accounts::Types::ListAccountMembersResponse.load(response.body)
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
      # @option params [String] :account_member_id
      #
      # @example
      #   client.accounts.get_account_member(account_member_id: "account_member_id")
      #
      # @return [Schematic::Accounts::Types::GetAccountMemberResponse]
      def get_account_member(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "account-members/#{URI.encode_uri_component(params[:account_member_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetAccountMemberResponse.load(response.body)
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
      # @option params [String, nil] :ids
      # @option params [String, nil] :q
      # @option params [Schematic::Types::AccountMemberRole, nil] :role
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.count_account_members(
      #     ids: ["ids"],
      #     q: "q",
      #     role: "admin",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::CountAccountMembersResponse]
      def count_account_members(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["role"] = params[:role] if params.key?(:role)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "account-members/count",
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
          Schematic::Accounts::Types::CountAccountMembersResponse.load(response.body)
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
      # @option params [String, nil] :environment_id
      # @option params [Boolean] :require_environment
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.list_api_keys(
      #     environment_id: "environment_id",
      #     require_environment: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::ListApiKeysResponse]
      def list_api_keys(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["environment_id"] = params[:environment_id] if params.key?(:environment_id)
        query_params["require_environment"] = params[:require_environment] if params.key?(:require_environment)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "api-keys",
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
          Schematic::Accounts::Types::ListApiKeysResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Accounts::Types::CreateApiKeyRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.create_api_key(name: "name")
      #
      # @return [Schematic::Accounts::Types::CreateApiKeyResponse]
      def create_api_key(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "api-keys",
          body: Schematic::Accounts::Types::CreateApiKeyRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::CreateApiKeyResponse.load(response.body)
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
      # @option params [String] :api_key_id
      #
      # @example
      #   client.accounts.get_api_key(api_key_id: "api_key_id")
      #
      # @return [Schematic::Accounts::Types::GetApiKeyResponse]
      def get_api_key(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "api-keys/#{URI.encode_uri_component(params[:api_key_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetApiKeyResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Accounts::Types::UpdateApiKeyRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :api_key_id
      #
      # @example
      #   client.accounts.update_api_key(api_key_id: "api_key_id")
      #
      # @return [Schematic::Accounts::Types::UpdateApiKeyResponse]
      def update_api_key(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Accounts::Types::UpdateApiKeyRequestBody.new(params).to_h
        non_body_param_names = %w[api_key_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "api-keys/#{URI.encode_uri_component(params[:api_key_id].to_s)}",
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
          Schematic::Accounts::Types::UpdateApiKeyResponse.load(response.body)
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
      # @option params [String] :api_key_id
      #
      # @example
      #   client.accounts.delete_api_key(api_key_id: "api_key_id")
      #
      # @return [Schematic::Accounts::Types::DeleteApiKeyResponse]
      def delete_api_key(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "api-keys/#{URI.encode_uri_component(params[:api_key_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::DeleteApiKeyResponse.load(response.body)
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
      # @option params [String, nil] :environment_id
      # @option params [Boolean] :require_environment
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.count_api_keys(
      #     environment_id: "environment_id",
      #     require_environment: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::CountApiKeysResponse]
      def count_api_keys(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["environment_id"] = params[:environment_id] if params.key?(:environment_id)
        query_params["require_environment"] = params[:require_environment] if params.key?(:require_environment)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "api-keys/count",
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
          Schematic::Accounts::Types::CountApiKeysResponse.load(response.body)
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
      # @option params [Schematic::Types::ActorType, nil] :actor_type
      # @option params [String, nil] :end_time
      # @option params [String, nil] :environment_id
      # @option params [String, nil] :q
      # @option params [String, nil] :start_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.list_audit_logs(
      #     actor_type: "api_key",
      #     end_time: "2024-01-15T09:30:00Z",
      #     environment_id: "environment_id",
      #     q: "q",
      #     start_time: "2024-01-15T09:30:00Z",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::ListAuditLogsResponse]
      def list_audit_logs(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["actor_type"] = params[:actor_type] if params.key?(:actor_type)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["environment_id"] = params[:environment_id] if params.key?(:environment_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "audit-log",
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
          Schematic::Accounts::Types::ListAuditLogsResponse.load(response.body)
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
      # @option params [String] :audit_log_id
      #
      # @example
      #   client.accounts.get_audit_log(audit_log_id: "audit_log_id")
      #
      # @return [Schematic::Accounts::Types::GetAuditLogResponse]
      def get_audit_log(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "audit-log/#{URI.encode_uri_component(params[:audit_log_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetAuditLogResponse.load(response.body)
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
      # @option params [Schematic::Types::ActorType, nil] :actor_type
      # @option params [String, nil] :end_time
      # @option params [String, nil] :environment_id
      # @option params [String, nil] :q
      # @option params [String, nil] :start_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.count_audit_logs(
      #     actor_type: "api_key",
      #     end_time: "2024-01-15T09:30:00Z",
      #     environment_id: "environment_id",
      #     q: "q",
      #     start_time: "2024-01-15T09:30:00Z",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::CountAuditLogsResponse]
      def count_audit_logs(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["actor_type"] = params[:actor_type] if params.key?(:actor_type)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["environment_id"] = params[:environment_id] if params.key?(:environment_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "audit-log/count",
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
          Schematic::Accounts::Types::CountAuditLogsResponse.load(response.body)
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
      # @option params [String, nil] :ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.accounts.list_environments(
      #     ids: ["ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Accounts::Types::ListEnvironmentsResponse]
      def list_environments(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "environments",
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
          Schematic::Accounts::Types::ListEnvironmentsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Accounts::Types::CreateEnvironmentRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.create_environment(
      #     environment_type: "development",
      #     name: "name"
      #   )
      #
      # @return [Schematic::Accounts::Types::CreateEnvironmentResponse]
      def create_environment(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "environments",
          body: Schematic::Accounts::Types::CreateEnvironmentRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::CreateEnvironmentResponse.load(response.body)
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
      # @option params [String] :environment_id
      #
      # @example
      #   client.accounts.get_environment(environment_id: "environment_id")
      #
      # @return [Schematic::Accounts::Types::GetEnvironmentResponse]
      def get_environment(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "environments/#{URI.encode_uri_component(params[:environment_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetEnvironmentResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Accounts::Types::UpdateEnvironmentRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :environment_id
      #
      # @example
      #   client.accounts.update_environment(environment_id: "environment_id")
      #
      # @return [Schematic::Accounts::Types::UpdateEnvironmentResponse]
      def update_environment(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Accounts::Types::UpdateEnvironmentRequestBody.new(params).to_h
        non_body_param_names = %w[environment_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "environments/#{URI.encode_uri_component(params[:environment_id].to_s)}",
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
          Schematic::Accounts::Types::UpdateEnvironmentResponse.load(response.body)
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
      # @option params [String] :environment_id
      #
      # @example
      #   client.accounts.delete_environment(environment_id: "environment_id")
      #
      # @return [Schematic::Accounts::Types::DeleteEnvironmentResponse]
      def delete_environment(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "environments/#{URI.encode_uri_component(params[:environment_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::DeleteEnvironmentResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param _params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.get_onboarding_state
      #
      # @return [Schematic::Accounts::Types::GetOnboardingStateResponse]
      def get_onboarding_state(request_options: {}, **_params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "onboarding-state",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetOnboardingStateResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Accounts::Types::UpdateOnboardingStateRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.update_onboarding_state
      #
      # @return [Schematic::Accounts::Types::UpdateOnboardingStateResponse]
      def update_onboarding_state(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "onboarding-state",
          body: Schematic::Accounts::Types::UpdateOnboardingStateRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::UpdateOnboardingStateResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param _params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.quickstart
      #
      # @return [Schematic::Accounts::Types::QuickstartResponse]
      def quickstart(request_options: {}, **_params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "quickstart",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::QuickstartResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param _params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.accounts.get_who_am_i
      #
      # @return [Schematic::Accounts::Types::GetWhoAmIResponse]
      def get_who_am_i(request_options: {}, **_params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "whoami",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Accounts::Types::GetWhoAmIResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
