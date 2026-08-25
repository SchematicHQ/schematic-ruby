# frozen_string_literal: true

module Schematic
  module Licenses
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
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [String, nil] :name
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.licenses.list_licenses(
      #     feature_ids: ["feature_ids"],
      #     ids: ["ids"],
      #     name: "name",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Licenses::Types::ListLicensesResponse]
      def list_licenses(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "licenses",
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
          Schematic::Licenses::Types::ListLicensesResponse.load(response.body)
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
      # @option params [String] :license_id
      #
      # @example
      #   client.licenses.get_single_license(license_id: "license_id")
      #
      # @return [Schematic::Licenses::Types::GetSingleLicenseResponse]
      def get_single_license(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "licenses/#{URI.encode_uri_component(params[:license_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Licenses::Types::GetSingleLicenseResponse.load(response.body)
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
      # @option params [String, nil] :feature_ids
      # @option params [String, nil] :ids
      # @option params [String, nil] :name
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.licenses.count_licenses(
      #     feature_ids: ["feature_ids"],
      #     ids: ["ids"],
      #     name: "name",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Licenses::Types::CountLicensesResponse]
      def count_licenses(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["feature_ids"] = params[:feature_ids] if params.key?(:feature_ids)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "licenses/count",
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
          Schematic::Licenses::Types::CountLicensesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
