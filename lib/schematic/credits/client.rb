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
      # @example
      #   client.credits.list_billing_credits(
      #     ids: ["ids"],
      #     name: "name",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListBillingCreditsResponse]
      def list_billing_credits(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.create_billing_credit(
      #     currency: "currency",
      #     description: "description",
      #     name: "name"
      #   )
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
      # @example
      #   client.credits.get_single_billing_credit(credit_id: "credit_id")
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
      # @example
      #   client.credits.update_billing_credit(
      #     credit_id: "credit_id",
      #     description: "description",
      #     name: "name"
      #   )
      #
      # @return [Schematic::Credits::Types::UpdateBillingCreditResponse]
      def update_billing_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::UpdateBillingCreditRequestBody.new(params).to_h
        non_body_param_names = %w[credit_id]
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
      # @example
      #   client.credits.soft_delete_billing_credit(credit_id: "credit_id")
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
      # @example
      #   client.credits.list_company_credit_balances(company_id: "company_id")
      #
      # @return [Schematic::Credits::Types::ListCompanyCreditBalancesResponse]
      def list_company_credit_balances(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)

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
      # @example
      #   client.credits.list_credit_bundles(
      #     ids: ["ids"],
      #     credit_id: "credit_id",
      #     status: "active",
      #     bundle_type: "fixed",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListCreditBundlesResponse]
      def list_credit_bundles(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["bundle_type"] = params[:bundle_type] if params.key?(:bundle_type)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.create_credit_bundle(
      #     bundle_name: "bundle_name",
      #     credit_id: "credit_id",
      #     currency: "currency",
      #     price_per_unit: 1000000
      #   )
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
      # @example
      #   client.credits.get_credit_bundle(bundle_id: "bundle_id")
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
      # @example
      #   client.credits.update_credit_bundle_details(
      #     bundle_id: "bundle_id",
      #     bundle_name: "bundle_name",
      #     price_per_unit: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::UpdateCreditBundleDetailsResponse]
      def update_credit_bundle_details(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::UpdateCreditBundleDetailsRequestBody.new(params).to_h
        non_body_param_names = %w[bundle_id]
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
      # @example
      #   client.credits.delete_credit_bundle(bundle_id: "bundle_id")
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
      # @example
      #   client.credits.count_credit_bundles(
      #     ids: ["ids"],
      #     credit_id: "credit_id",
      #     status: "active",
      #     bundle_type: "fixed",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountCreditBundlesResponse]
      def count_credit_bundles(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["bundle_type"] = params[:bundle_type] if params.key?(:bundle_type)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.count_billing_credits(
      #     ids: ["ids"],
      #     name: "name",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountBillingCreditsResponse]
      def count_billing_credits(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.zero_out_grant(grant_id: "grant_id")
      #
      # @return [Schematic::Credits::Types::ZeroOutGrantResponse]
      def zero_out_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::ZeroOutGrantRequestBody.new(params).to_h
        non_body_param_names = %w[grant_id]
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
      # @example
      #   client.credits.grant_billing_credits_to_company(
      #     company_id: "company_id",
      #     credit_id: "credit_id",
      #     quantity: 1000000,
      #     reason: "adjustment"
      #   )
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
      # @option params [String] :company_id
      # @option params [Schematic::Types::CreditGrantSortOrder, nil] :order
      # @option params [Schematic::Types::SortDirection, nil] :dir
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.count_company_grants(
      #     company_id: "company_id",
      #     order: "created_at",
      #     dir: "asc",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountCompanyGrantsResponse]
      def count_company_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["order"] = params[:order] if params.key?(:order)
        query_params["dir"] = params[:dir] if params.key?(:dir)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @option params [String] :company_id
      # @option params [Schematic::Types::CreditGrantSortOrder, nil] :order
      # @option params [Schematic::Types::SortDirection, nil] :dir
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.list_company_grants(
      #     company_id: "company_id",
      #     order: "created_at",
      #     dir: "asc",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListCompanyGrantsResponse]
      def list_company_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["order"] = params[:order] if params.key?(:order)
        query_params["dir"] = params[:dir] if params.key?(:dir)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.count_billing_credits_grants(
      #     credit_id: "credit_id",
      #     ids: ["ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountBillingCreditsGrantsResponse]
      def count_billing_credits_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.list_grants_for_credit(
      #     credit_id: "credit_id",
      #     ids: ["ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListGrantsForCreditResponse]
      def list_grants_for_credit(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @param params [Schematic::Credits::Types::AcquireCreditLeaseRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.credits.acquire_credit_lease(
      #     company_id: "company_id",
      #     credit_type_id: "credit_type_id",
      #     requested_amount: 1.1
      #   )
      #
      # @return [Schematic::Credits::Types::AcquireCreditLeaseResponse]
      def acquire_credit_lease(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits/lease",
          body: Schematic::Credits::Types::AcquireCreditLeaseRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::AcquireCreditLeaseResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::ExtendCreditLeaseRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :lease_id
      #
      # @example
      #   client.credits.extend_credit_lease(
      #     lease_id: "lease_id",
      #     additional_amount: 1.1
      #   )
      #
      # @return [Schematic::Credits::Types::ExtendCreditLeaseResponse]
      def extend_credit_lease(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::ExtendCreditLeaseRequestBody.new(params).to_h
        non_body_param_names = %w[lease_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/lease/#{URI.encode_uri_component(params[:lease_id].to_s)}/extend",
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
          Schematic::Credits::Types::ExtendCreditLeaseResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::ReleaseCreditLeaseRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :lease_id
      #
      # @example
      #   client.credits.release_credit_lease(
      #     lease_id: "lease_id",
      #     request: {
      #       key: "value"
      #     }
      #   )
      #
      # @return [Schematic::Credits::Types::ReleaseCreditLeaseResponse]
      def release_credit_lease(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[lease_id]
        body_params = params.except(*path_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/lease/#{URI.encode_uri_component(params[:lease_id].to_s)}/release",
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
          Schematic::Credits::Types::ReleaseCreditLeaseResponse.load(response.body)
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
      # @option params [String, nil] :plan_version_ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.list_billing_plan_credit_grants(
      #     credit_id: "credit_id",
      #     ids: ["ids"],
      #     plan_id: "plan_id",
      #     plan_ids: ["plan_ids"],
      #     plan_version_id: "plan_version_id",
      #     plan_version_ids: ["plan_version_ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListBillingPlanCreditGrantsResponse]
      def list_billing_plan_credit_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["plan_version_ids"] = params[:plan_version_ids] if params.key?(:plan_version_ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.create_billing_plan_credit_grant(
      #     credit_amount: 1000000,
      #     credit_id: "credit_id",
      #     plan_id: "plan_id",
      #     reset_cadence: "daily",
      #     reset_start: "billing_period"
      #   )
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
      # @example
      #   client.credits.get_single_billing_plan_credit_grant(plan_grant_id: "plan_grant_id")
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
      # @example
      #   client.credits.update_billing_plan_credit_grant(
      #     plan_grant_id: "plan_grant_id",
      #     reset_cadence: "daily",
      #     reset_start: "billing_period"
      #   )
      #
      # @return [Schematic::Credits::Types::UpdateBillingPlanCreditGrantResponse]
      def update_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[plan_grant_id]
        body_params = params.except(*path_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/plan-grants/#{URI.encode_uri_component(params[:plan_grant_id].to_s)}",
          body: Schematic::Types::UpdateBillingPlanCreditGrantRequestBody.new(body_params).to_h,
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
      # @example
      #   client.credits.delete_billing_plan_credit_grant(
      #     plan_grant_id: "plan_grant_id",
      #     apply_to_existing: true
      #   )
      #
      # @return [Schematic::Credits::Types::DeleteBillingPlanCreditGrantResponse]
      def delete_billing_plan_credit_grant(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["apply_to_existing"] = params[:apply_to_existing] if params.key?(:apply_to_existing)

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
      # @option params [String, nil] :plan_version_ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.count_billing_plan_credit_grants(
      #     credit_id: "credit_id",
      #     ids: ["ids"],
      #     plan_id: "plan_id",
      #     plan_ids: ["plan_ids"],
      #     plan_version_id: "plan_version_id",
      #     plan_version_ids: ["plan_version_ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountBillingPlanCreditGrantsResponse]
      def count_billing_plan_credit_grants(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["credit_id"] = params[:credit_id] if params.key?(:credit_id)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["plan_id"] = params[:plan_id] if params.key?(:plan_id)
        query_params["plan_ids"] = params[:plan_ids] if params.key?(:plan_ids)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
        query_params["plan_version_ids"] = params[:plan_version_ids] if params.key?(:plan_version_ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @option params [String, nil] :company_id
      # @option params [Schematic::Types::CreditSpendPolicyScope, nil] :scope_type
      # @option params [String, nil] :user_id
      # @option params [String, nil] :user_ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.list_credit_spend_policies(
      #     billing_credit_id: "billing_credit_id",
      #     company_id: "company_id",
      #     scope_type: "company",
      #     user_id: "user_id",
      #     user_ids: ["user_ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListCreditSpendPoliciesResponse]
      def list_credit_spend_policies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["scope_type"] = params[:scope_type] if params.key?(:scope_type)
        query_params["user_id"] = params[:user_id] if params.key?(:user_id)
        query_params["user_ids"] = params[:user_ids] if params.key?(:user_ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/spend-policies",
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
          Schematic::Credits::Types::ListCreditSpendPoliciesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::CreateCreditSpendPolicyRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.credits.create_credit_spend_policy(
      #     billing_credit_id: "billing_credit_id",
      #     max_per_draw: 1.1
      #   )
      #
      # @return [Schematic::Credits::Types::CreateCreditSpendPolicyResponse]
      def create_credit_spend_policy(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/credits/spend-policies",
          body: Schematic::Credits::Types::CreateCreditSpendPolicyRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::CreateCreditSpendPolicyResponse.load(response.body)
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
      # @option params [String] :spend_policy_id
      #
      # @example
      #   client.credits.get_credit_spend_policy(spend_policy_id: "spend_policy_id")
      #
      # @return [Schematic::Credits::Types::GetCreditSpendPolicyResponse]
      def get_credit_spend_policy(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/spend-policies/#{URI.encode_uri_component(params[:spend_policy_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::GetCreditSpendPolicyResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Credits::Types::UpdateCreditSpendPolicyRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :spend_policy_id
      #
      # @example
      #   client.credits.update_credit_spend_policy(spend_policy_id: "spend_policy_id")
      #
      # @return [Schematic::Credits::Types::UpdateCreditSpendPolicyResponse]
      def update_credit_spend_policy(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Credits::Types::UpdateCreditSpendPolicyRequestBody.new(params).to_h
        non_body_param_names = %w[spend_policy_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/credits/spend-policies/#{URI.encode_uri_component(params[:spend_policy_id].to_s)}",
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
          Schematic::Credits::Types::UpdateCreditSpendPolicyResponse.load(response.body)
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
      # @option params [String] :spend_policy_id
      #
      # @example
      #   client.credits.delete_credit_spend_policy(spend_policy_id: "spend_policy_id")
      #
      # @return [Schematic::Credits::Types::DeleteCreditSpendPolicyResponse]
      def delete_credit_spend_policy(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/credits/spend-policies/#{URI.encode_uri_component(params[:spend_policy_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Credits::Types::DeleteCreditSpendPolicyResponse.load(response.body)
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
      # @option params [String, nil] :company_id
      # @option params [Schematic::Types::CreditSpendPolicyScope, nil] :scope_type
      # @option params [String, nil] :user_id
      # @option params [String, nil] :user_ids
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.credits.count_credit_spend_policies(
      #     billing_credit_id: "billing_credit_id",
      #     company_id: "company_id",
      #     scope_type: "company",
      #     user_id: "user_id",
      #     user_ids: ["user_ids"],
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountCreditSpendPoliciesResponse]
      def count_credit_spend_policies(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["scope_type"] = params[:scope_type] if params.key?(:scope_type)
        query_params["user_id"] = params[:user_id] if params.key?(:user_id)
        query_params["user_ids"] = params[:user_ids] if params.key?(:user_ids)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/credits/spend-policies/count",
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
          Schematic::Credits::Types::CountCreditSpendPoliciesResponse.load(response.body)
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
      # @example
      #   client.credits.list_credit_event_ledger(
      #     billing_credit_id: "billing_credit_id",
      #     company_id: "company_id",
      #     end_time: "end_time",
      #     event_type: "grant",
      #     feature_id: "feature_id",
      #     start_time: "start_time",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::ListCreditEventLedgerResponse]
      def list_credit_event_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["event_type"] = params[:event_type] if params.key?(:event_type)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.credits.count_credit_event_ledger(
      #     billing_credit_id: "billing_credit_id",
      #     company_id: "company_id",
      #     end_time: "end_time",
      #     event_type: "grant",
      #     feature_id: "feature_id",
      #     start_time: "start_time",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Credits::Types::CountCreditEventLedgerResponse]
      def count_credit_event_ledger(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["billing_credit_id"] = params[:billing_credit_id] if params.key?(:billing_credit_id)
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["end_time"] = params[:end_time] if params.key?(:end_time)
        query_params["event_type"] = params[:event_type] if params.key?(:event_type)
        query_params["feature_id"] = params[:feature_id] if params.key?(:feature_id)
        query_params["start_time"] = params[:start_time] if params.key?(:start_time)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
