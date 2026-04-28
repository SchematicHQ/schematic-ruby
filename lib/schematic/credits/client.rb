# frozen_string_literal: true

module Schematic
  module Credits
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
      # @option params [String, nil] :name
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListBillingCreditsResponse]
      def list_billing_credits(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids name limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits",
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
          Schematic::Credits::Types::ListBillingCreditsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::CreateBillingCreditRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Credits::Types::CreateBillingCreditResponse]
      def create_billing_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits",
          body: Schematic::Credits::Types::CreateBillingCreditRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::CreateBillingCreditResponse.load(response.body)
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
      # @option params [String] :credit_id
      #
      # @return [Schematic::Credits::Types::GetSingleBillingCreditResponse]
      def get_single_billing_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/#{URI.encode_uri_component(params[:credit_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::GetSingleBillingCreditResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::UpdateBillingCreditRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :credit_id
      #
      # @return [Schematic::Credits::Types::UpdateBillingCreditResponse]
      def update_billing_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::UpdateBillingCreditRequestBody.new(params).to_h
        non_body_param_names = ["credit_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/#{URI.encode_uri_component(params[:credit_id].to_s)}",
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
          Schematic::Credits::Types::UpdateBillingCreditResponse.load(response.body)
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
      # @option params [String] :credit_id
      #
      # @return [Schematic::Credits::Types::SoftDeleteBillingCreditResponse]
      def soft_delete_billing_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/credits/#{URI.encode_uri_component(params[:credit_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::SoftDeleteBillingCreditResponse.load(response.body)
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
      #
      # @return [Schematic::Credits::Types::ListCompanyCreditBalancesResponse]
      def list_company_credit_balances(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/balance",
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
          Schematic::Credits::Types::ListCompanyCreditBalancesResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [Schematic::Types::BillingCreditBundleStatus, nil] :status
      # @option params [String, nil] :bundle_type
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListCreditBundlesResponse]
      def list_credit_bundles(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids credit_id status bundle_type limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["bundle_type"] = params[:bundle_type] if params.key?(:bundle_type)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/bundles",
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
          Schematic::Credits::Types::ListCreditBundlesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::CreateCreditBundleRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Credits::Types::CreateCreditBundleResponse]
      def create_credit_bundle(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits/bundles",
          body: Schematic::Credits::Types::CreateCreditBundleRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::CreateCreditBundleResponse.load(response.body)
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
      # @option params [String] :bundle_id
      #
      # @return [Schematic::Credits::Types::GetCreditBundleResponse]
      def get_credit_bundle(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/bundles/#{URI.encode_uri_component(params[:bundle_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::GetCreditBundleResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::UpdateCreditBundleDetailsRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :bundle_id
      #
      # @return [Schematic::Credits::Types::UpdateCreditBundleDetailsResponse]
      def update_credit_bundle_details(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::UpdateCreditBundleDetailsRequestBody.new(params).to_h
        non_body_param_names = ["bundle_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/bundles/#{URI.encode_uri_component(params[:bundle_id].to_s)}",
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
          Schematic::Credits::Types::UpdateCreditBundleDetailsResponse.load(response.body)
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
      # @option params [String] :bundle_id
      #
      # @return [Schematic::Credits::Types::DeleteCreditBundleResponse]
      def delete_credit_bundle(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/credits/bundles/#{URI.encode_uri_component(params[:bundle_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::DeleteCreditBundleResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [Schematic::Types::BillingCreditBundleStatus, nil] :status
      # @option params [String, nil] :bundle_type
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountCreditBundlesResponse]
      def count_credit_bundles(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids credit_id status bundle_type limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["bundle_type"] = params[:bundle_type] if params.key?(:bundle_type)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/bundles/count",
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
          Schematic::Credits::Types::CountCreditBundlesResponse.load(response.body)
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
      # @option params [String, nil] :name
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountBillingCreditsResponse]
      def count_billing_credits(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids name limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/count",
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
          Schematic::Credits::Types::CountBillingCreditsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::ZeroOutGrantRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :grant_id
      #
      # @return [Schematic::Credits::Types::ZeroOutGrantResponse]
      def zero_out_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::ZeroOutGrantRequestBody.new(params).to_h
        non_body_param_names = ["grant_id"]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/grants/#{URI.encode_uri_component(params[:grant_id].to_s)}/zero-out",
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
          Schematic::Credits::Types::ZeroOutGrantResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::CreateCompanyCreditGrant]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Credits::Types::GrantBillingCreditsToCompanyResponse]
      def grant_billing_credits_to_company(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits/grants/company",
          body: Schematic::Credits::Types::CreateCompanyCreditGrant.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::GrantBillingCreditsToCompanyResponse.load(response.body)
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
      # @option params [Schematic::Types::CreditGrantSortOrder, nil] :order
      # @option params [Schematic::Types::SortDirection, nil] :dir
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountCompanyGrantsResponse]
      def count_company_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id order dir limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["order"] = params[:order] if params.key?(:order)
        query_params["dir"] = params[:dir] if params.key?(:dir)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/grants/company/count",
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
          Schematic::Credits::Types::CountCompanyGrantsResponse.load(response.body)
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
      # @option params [Schematic::Types::CreditGrantSortOrder, nil] :order
      # @option params [Schematic::Types::SortDirection, nil] :dir
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListCompanyGrantsResponse]
      def list_company_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id order dir limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["order"] = params[:order] if params.key?(:order)
        query_params["dir"] = params[:dir] if params.key?(:dir)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/grants/company/list",
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
          Schematic::Credits::Types::ListCompanyGrantsResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [String, nil] :ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountBillingCreditsGrantsResponse]
      def count_billing_credits_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[credit_id ids limit offset]
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/grants/count",
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
          Schematic::Credits::Types::CountBillingCreditsGrantsResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [String, nil] :ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListGrantsForCreditResponse]
      def list_grants_for_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[credit_id ids limit offset]
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/grants/list",
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
          Schematic::Credits::Types::ListGrantsForCreditResponse.load(response.body)
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
      # @option params [String, nil] :billing_credit_id
      # @option params [String, nil] :feature_id
      # @option params [Schematic::Types::CreditLedgerPeriod] :period
      # @option params [String, nil] :start_time
      # @option params [String, nil] :end_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::GetEnrichedCreditLedgerResponse]
      def get_enriched_credit_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id billing_credit_id feature_id period start_time end_time limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["period"] = params[:period] if params.key?(:period)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/ledger",
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
          Schematic::Credits::Types::GetEnrichedCreditLedgerResponse.load(response.body)
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
      # @option params [String, nil] :billing_credit_id
      # @option params [String, nil] :feature_id
      # @option params [Schematic::Types::CreditLedgerPeriod] :period
      # @option params [String, nil] :start_time
      # @option params [String, nil] :end_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountCreditLedgerResponse]
      def count_credit_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id billing_credit_id feature_id period start_time end_time limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["period"] = params[:period] if params.key?(:period)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/ledger/count",
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
          Schematic::Credits::Types::CountCreditLedgerResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [String, nil] :ids
      # @option params [String, nil] :plan_id
      # @option params [String, nil] :plan_ids
      # @option params [String, nil] :plan_version_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListBillingPlanCreditGrantsResponse]
      def list_billing_plan_credit_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[credit_id ids plan_id plan_ids plan_version_id limit offset]
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/plan-grants",
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
          Schematic::Credits::Types::ListBillingPlanCreditGrantsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::CreateBillingPlanCreditGrantRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Credits::Types::CreateBillingPlanCreditGrantResponse]
      def create_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits/plan-grants",
          body: Schematic::Types::CreateBillingPlanCreditGrantRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::CreateBillingPlanCreditGrantResponse.load(response.body)
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
      # @option params [String] :plan_grant_id
      #
      # @return [Schematic::Credits::Types::GetSingleBillingPlanCreditGrantResponse]
      def get_single_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/plan-grants/#{URI.encode_uri_component(params[:plan_grant_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::GetSingleBillingPlanCreditGrantResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::UpdateBillingPlanCreditGrantRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :plan_grant_id
      #
      # @return [Schematic::Credits::Types::UpdateBillingPlanCreditGrantResponse]
      def update_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/plan-grants/#{URI.encode_uri_component(params[:plan_grant_id].to_s)}",
          body: Schematic::Types::UpdateBillingPlanCreditGrantRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::UpdateBillingPlanCreditGrantResponse.load(response.body)
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
      # @option params [String] :plan_grant_id
      # @option params [Boolean, nil] :apply_to_existing
      #
      # @return [Schematic::Credits::Types::DeleteBillingPlanCreditGrantResponse]
      def delete_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[apply_to_existing]
        query_params = {}
        query_params["apply_to_existing"] = params[:apply_to_existing] if params.key?(:apply_to_existing)
        params = params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/credits/plan-grants/#{URI.encode_uri_component(params[:plan_grant_id].to_s)}",
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
          Schematic::Credits::Types::DeleteBillingPlanCreditGrantResponse.load(response.body)
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
      # @option params [String, nil] :credit_id
      # @option params [String, nil] :ids
      # @option params [String, nil] :plan_id
      # @option params [String, nil] :plan_ids
      # @option params [String, nil] :plan_version_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountBillingPlanCreditGrantsResponse]
      def count_billing_plan_credit_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[credit_id ids plan_id plan_ids plan_version_id limit offset]
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/plan-grants/count",
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
          Schematic::Credits::Types::CountBillingPlanCreditGrantsResponse.load(response.body)
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
      # @option params [String, nil] :billing_credit_id
      # @option params [String] :company_id
      # @option params [String, nil] :end_time
      # @option params [Schematic::Types::CreditEventType, nil] :event_type
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :start_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::ListCreditEventLedgerResponse]
      def list_credit_event_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[billing_credit_id company_id end_time event_type feature_id start_time limit offset]
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["event_type"] = params[:event_type] if params.key?(:event_type)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v2/billing/credits/ledger",
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
          Schematic::Credits::Types::ListCreditEventLedgerResponse.load(response.body)
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
      # @option params [String, nil] :billing_credit_id
      # @option params [String] :company_id
      # @option params [String, nil] :end_time
      # @option params [Schematic::Types::CreditEventType, nil] :event_type
      # @option params [String, nil] :feature_id
      # @option params [String, nil] :start_time
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Credits::Types::CountCreditEventLedgerResponse]
      def count_credit_event_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[billing_credit_id company_id end_time event_type feature_id start_time limit offset]
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["event_type"] = params[:event_type] if params.key?(:event_type)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v2/billing/credits/ledger/count",
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
          Schematic::Credits::Types::CountCreditEventLedgerResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
