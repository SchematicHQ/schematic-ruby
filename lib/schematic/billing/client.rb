# frozen_string_literal: true

module Schematic
  module Billing
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
      # @option params [Boolean, nil] :is_active
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListCouponsResponse]
      def list_coupons(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[is_active q limit offset]
        query_params = {}
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/coupons",
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
          Schematic::Billing::Types::ListCouponsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateCouponRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingCouponResponse]
      def upsert_billing_coupon(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/coupons",
          body: Schematic::Billing::Types::CreateCouponRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingCouponResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateBillingCustomerRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingCustomerResponse]
      def upsert_billing_customer(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/customer/upsert",
          body: Schematic::Billing::Types::CreateBillingCustomerRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingCustomerResponse.load(response.body)
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
      # @option params [String, nil] :company_ids
      # @option params [String, nil] :name
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListCustomersWithSubscriptionsResponse]
      def list_customers_with_subscriptions(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_ids name provider_type q limit offset]
        query_params = {}
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/customers",
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
          Schematic::Billing::Types::ListCustomersWithSubscriptionsResponse.load(response.body)
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
      # @option params [String, nil] :company_ids
      # @option params [String, nil] :name
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::CountCustomersResponse]
      def count_customers(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_ids name provider_type q limit offset]
        query_params = {}
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/customers/count",
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
          Schematic::Billing::Types::CountCustomersResponse.load(response.body)
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
      # @option params [String] :customer_external_id
      # @option params [String] :subscription_external_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListInvoicesResponse]
      def list_invoices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id customer_external_id subscription_external_id limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["customer_external_id"] = params[:customer_external_id] if params.key?(:customer_external_id)
        query_params["subscription_external_id"] = params[:subscription_external_id] if params.key?(:subscription_external_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/invoices",
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
          Schematic::Billing::Types::ListInvoicesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateInvoiceRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertInvoiceResponse]
      def upsert_invoice(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/invoices",
          body: Schematic::Billing::Types::CreateInvoiceRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertInvoiceResponse.load(response.body)
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
      # @option params [String, nil] :display_name
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListMetersResponse]
      def list_meters(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[display_name limit offset]
        query_params = {}
        query_params["display_name"] = params[:display_name] if params.key?(:display_name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/meter",
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
          Schematic::Billing::Types::ListMetersResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateMeterRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingMeterResponse]
      def upsert_billing_meter(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/meter/upsert",
          body: Schematic::Billing::Types::CreateMeterRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingMeterResponse.load(response.body)
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
      # @option params [String] :customer_external_id
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListPaymentMethodsResponse]
      def list_payment_methods(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[company_id customer_external_id limit offset]
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["customer_external_id"] = params[:customer_external_id] if params.key?(:customer_external_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/payment-methods",
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
          Schematic::Billing::Types::ListPaymentMethodsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreatePaymentMethodRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertPaymentMethodResponse]
      def upsert_payment_method(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/payment-methods",
          body: Schematic::Billing::Types::CreatePaymentMethodRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertPaymentMethodResponse.load(response.body)
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
      # @option params [String, nil] :currency
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [String, nil] :ids
      # @option params [String, nil] :interval
      # @option params [Boolean, nil] :is_active
      # @option params [Integer, nil] :price
      # @option params [String, nil] :product_id
      # @option params [String, nil] :product_ids
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Schematic::Types::BillingTiersMode, nil] :tiers_mode
      # @option params [Schematic::Types::BillingPriceUsageType, nil] :usage_type
      # @option params [Boolean, nil] :with_meter
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListBillingPricesResponse]
      def list_billing_prices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[currency for_initial_plan for_trial_expiry_plan ids interval is_active price product_id product_ids provider_type q tiers_mode usage_type with_meter limit offset]
        query_params = {}
        query_params["currency"] = params[:currency] if params.key?(:currency)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["interval"] = params[:interval] if params.key?(:interval)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["price"] = params[:price] if params.key?(:price)
        query_params["product_id"] = params[:product_id] if params.key?(:product_id)
        query_params["product_ids"] = params[:product_ids] if params.key?(:product_ids)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["tiers_mode"] = params[:tiers_mode] if params.key?(:tiers_mode)
        query_params["usage_type"] = params[:usage_type] if params.key?(:usage_type)
        query_params["with_meter"] = params[:with_meter] if params.key?(:with_meter)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/price",
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
          Schematic::Billing::Types::ListBillingPricesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateBillingPriceRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingPriceResponse]
      def upsert_billing_price(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/price/upsert",
          body: Schematic::Billing::Types::CreateBillingPriceRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingPriceResponse.load(response.body)
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
      # @option params [String] :billing_id
      #
      # @return [Schematic::Billing::Types::DeleteBillingProductResponse]
      def delete_billing_product(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/product/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeleteBillingProductResponse.load(response.body)
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
      # @option params [String, nil] :currency
      # @option params [Boolean, nil] :for_initial_plan
      # @option params [Boolean, nil] :for_trial_expiry_plan
      # @option params [String, nil] :ids
      # @option params [String, nil] :interval
      # @option params [Boolean, nil] :is_active
      # @option params [Integer, nil] :price
      # @option params [String, nil] :product_id
      # @option params [String, nil] :product_ids
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Schematic::Types::BillingTiersMode, nil] :tiers_mode
      # @option params [Schematic::Types::BillingPriceUsageType, nil] :usage_type
      # @option params [Boolean, nil] :with_meter
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListBillingProductPricesResponse]
      def list_billing_product_prices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[currency for_initial_plan for_trial_expiry_plan ids interval is_active price product_id product_ids provider_type q tiers_mode usage_type with_meter limit offset]
        query_params = {}
        query_params["currency"] = params[:currency] if params.key?(:currency)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["interval"] = params[:interval] if params.key?(:interval)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["price"] = params[:price] if params.key?(:price)
        query_params["product_id"] = params[:product_id] if params.key?(:product_id)
        query_params["product_ids"] = params[:product_ids] if params.key?(:product_ids)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["tiers_mode"] = params[:tiers_mode] if params.key?(:tiers_mode)
        query_params["usage_type"] = params[:usage_type] if params.key?(:usage_type)
        query_params["with_meter"] = params[:with_meter] if params.key?(:with_meter)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/product/prices",
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
          Schematic::Billing::Types::ListBillingProductPricesResponse.load(response.body)
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
      # @option params [String] :billing_id
      #
      # @return [Schematic::Billing::Types::DeleteProductPriceResponse]
      def delete_product_price(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/product/prices/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeleteProductPriceResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateBillingProductRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingProductResponse]
      def upsert_billing_product(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/product/upsert",
          body: Schematic::Billing::Types::CreateBillingProductRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingProductResponse.load(response.body)
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
      # @option params [Boolean, nil] :is_active
      # @option params [String, nil] :name
      # @option params [Schematic::Types::BillingPriceUsageType, nil] :price_usage_type
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :with_one_time_charges
      # @option params [Boolean, nil] :with_prices_only
      # @option params [Boolean, nil] :with_zero_price
      # @option params [Boolean, nil] :without_linked_to_plan
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::ListBillingProductsResponse]
      def list_billing_products(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids is_active name price_usage_type provider_type q with_one_time_charges with_prices_only with_zero_price without_linked_to_plan limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["price_usage_type"] = params[:price_usage_type] if params.key?(:price_usage_type)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["with_one_time_charges"] = params[:with_one_time_charges] if params.key?(:with_one_time_charges)
        query_params["with_prices_only"] = params[:with_prices_only] if params.key?(:with_prices_only)
        query_params["with_zero_price"] = params[:with_zero_price] if params.key?(:with_zero_price)
        query_params["without_linked_to_plan"] = params[:without_linked_to_plan] if params.key?(:without_linked_to_plan)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/products",
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
          Schematic::Billing::Types::ListBillingProductsResponse.load(response.body)
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
      # @option params [Boolean, nil] :is_active
      # @option params [String, nil] :name
      # @option params [Schematic::Types::BillingPriceUsageType, nil] :price_usage_type
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [String, nil] :q
      # @option params [Boolean, nil] :with_one_time_charges
      # @option params [Boolean, nil] :with_prices_only
      # @option params [Boolean, nil] :with_zero_price
      # @option params [Boolean, nil] :without_linked_to_plan
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @return [Schematic::Billing::Types::CountBillingProductsResponse]
      def count_billing_products(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_param_names = %i[ids is_active name price_usage_type provider_type q with_one_time_charges with_prices_only with_zero_price without_linked_to_plan limit offset]
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["price_usage_type"] = params[:price_usage_type] if params.key?(:price_usage_type)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["with_one_time_charges"] = params[:with_one_time_charges] if params.key?(:with_one_time_charges)
        query_params["with_prices_only"] = params[:with_prices_only] if params.key?(:with_prices_only)
        query_params["with_zero_price"] = params[:with_zero_price] if params.key?(:with_zero_price)
        query_params["without_linked_to_plan"] = params[:without_linked_to_plan] if params.key?(:without_linked_to_plan)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)
        params.except(*query_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/products/count",
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
          Schematic::Billing::Types::CountBillingProductsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::CreateBillingSubscriptionRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @return [Schematic::Billing::Types::UpsertBillingSubscriptionResponse]
      def upsert_billing_subscription(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "billing/subscription/upsert",
          body: Schematic::Billing::Types::CreateBillingSubscriptionRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::UpsertBillingSubscriptionResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
