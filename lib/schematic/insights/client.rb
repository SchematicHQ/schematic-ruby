# frozen_string_literal: true

module Schematic
  module Insights
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
      # @option params [Integer, nil] :limit
      #
      # @example
      #   client.insights.get_activity(limit: 1000000)
      #
      # @return [Schematic::Insights::Types::GetActivityResponse]
      def get_activity(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["limit"] = params[:limit] if params.key?(:limit)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/activity",
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
          Schematic::Insights::Types::GetActivityResponse.load(response.body)
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
      # @option params [String] :end_time
      # @option params [String] :feature_id
      # @option params [Schematic::Types::TimeSeriesGranularity, nil] :granularity
      # @option params [String] :start_time
      #
      # @example
      #   client.insights.get_environment_feature_usage_time_series(
      #     end_time: "2024-01-15T09:30:00Z",
      #     feature_id: "feature_id",
      #     granularity: "daily",
      #     start_time: "2024-01-15T09:30:00Z"
      #   )
      #
      # @return [Schematic::Insights::Types::GetEnvironmentFeatureUsageTimeSeriesResponse]
      def get_environment_feature_usage_time_series(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["granularity"] = params[:granularity] if params.key?(:granularity)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/feature-usage-timeseries",
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
          Schematic::Insights::Types::GetEnvironmentFeatureUsageTimeSeriesResponse.load(response.body)
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
      # @option params [Integer, nil] :months
      #
      # @example
      #   client.insights.get_plan_growth(months: 1000000)
      #
      # @return [Schematic::Insights::Types::GetPlanGrowthResponse]
      def get_plan_growth(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["months"] = params[:months] if params.key?(:months)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/plan-growth",
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
          Schematic::Insights::Types::GetPlanGrowthResponse.load(response.body)
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
      #   client.insights.get_summary
      #
      # @return [Schematic::Insights::Types::GetSummaryResponse]
      def get_summary(request_options: {}, **_params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/summary",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Insights::Types::GetSummaryResponse.load(response.body)
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
      # @option params [String] :end_time
      # @option params [Integer, nil] :limit
      # @option params [String] :start_time
      #
      # @example
      #   client.insights.get_top_features_by_usage(
      #     end_time: "2024-01-15T09:30:00Z",
      #     limit: 1000000,
      #     start_time: "2024-01-15T09:30:00Z"
      #   )
      #
      # @return [Schematic::Insights::Types::GetTopFeaturesByUsageResponse]
      def get_top_features_by_usage(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/top-features",
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
          Schematic::Insights::Types::GetTopFeaturesByUsageResponse.load(response.body)
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
      # @option params [String] :end_time
      # @option params [String] :feature_id
      # @option params [Schematic::Types::TimeSeriesGranularity, nil] :granularity
      # @option params [String] :start_time
      #
      # @example
      #   client.insights.get_environment_trait_usage_time_series(
      #     end_time: "2024-01-15T09:30:00Z",
      #     feature_id: "feature_id",
      #     granularity: "daily",
      #     start_time: "2024-01-15T09:30:00Z"
      #   )
      #
      # @return [Schematic::Insights::Types::GetEnvironmentTraitUsageTimeSeriesResponse]
      def get_environment_trait_usage_time_series(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["granularity"] = params[:granularity] if params.key?(:granularity)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "insights/trait-usage-timeseries",
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
          Schematic::Insights::Types::GetEnvironmentTraitUsageTimeSeriesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
