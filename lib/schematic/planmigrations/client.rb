# frozen_string_literal: true

module Schematic
  module Planmigrations
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
      # @option params [String, nil] :migration_id
      # @option params [String, nil] :q
      # @option params [Schematic::Types::PlanVersionCompanyMigrationStatus, nil] :status
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Planmigrations::Types::ListCompanyMigrationsResponse]
      def list_company_migrations(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[migration_id q status limit offset]
        query_params = {}
        query_params["migration_id"] = params[:migration_id] if params.key?(:migration_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-version-company-migrations",
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
          Schematic::Planmigrations::Types::ListCompanyMigrationsResponse.load(response.body)
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
      # @option params [String, nil] :migration_id
      # @option params [String, nil] :q
      # @option params [Schematic::Types::PlanVersionCompanyMigrationStatus, nil] :status
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Planmigrations::Types::CountCompanyMigrationsResponse]
      def count_company_migrations(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[migration_id q status limit offset]
        query_params = {}
        query_params["migration_id"] = params[:migration_id] if params.key?(:migration_id)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-version-company-migrations/count",
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
          Schematic::Planmigrations::Types::CountCompanyMigrationsResponse.load(response.body)
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
      # @option params [String, nil] :plan_version_id
      # @option params [Schematic::Types::PlanVersionMigrationStatus, nil] :status
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Planmigrations::Types::ListMigrationsResponse]
      def list_migrations(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[plan_version_id status limit offset]
        query_params = {}
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-version-migrations",
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
          Schematic::Planmigrations::Types::ListMigrationsResponse.load(response.body)
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
      # @option params [String] :plan_version_migration_id
      #
      # @return [Schematic::Planmigrations::Types::GetMigrationResponse]
      def get_migration(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-version-migrations/#{URI.encode_uri_component(params[:plan_version_migration_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Planmigrations::Types::GetMigrationResponse.load(response.body)
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
      # @option params [String, nil] :plan_version_id
      # @option params [Schematic::Types::PlanVersionMigrationStatus, nil] :status
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Planmigrations::Types::CountMigrationsResponse]
      def count_migrations(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[plan_version_id status limit offset]
        query_params = {}
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "plan-version-migrations/count",
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
          Schematic::Planmigrations::Types::CountMigrationsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
