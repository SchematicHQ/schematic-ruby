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
      # @example
      #   client.billing.list_coupons(
      #     is_active: true,
      #     q: "q",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListCouponsResponse]
      def list_coupons(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.upsert_billing_coupon(
      #     amount_off: 1000000,
      #     duration: "duration",
      #     duration_in_months: 1000000,
      #     external_id: "external_id",
      #     max_redemptions: 1000000,
      #     name: "name",
      #     percent_off: 1.1,
      #     times_redeemed: 1000000
      #   )
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
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :billing_id
      #
      # @example
      #   client.billing.delete_billing_coupon(billing_id: "billing_id")
      #
      # @return [Schematic::Billing::Types::DeleteBillingCouponResponse]
      def delete_billing_coupon(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/coupons/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeleteBillingCouponResponse.load(response.body)
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
      # @example
      #   client.billing.delete_billing_customer(billing_id: "billing_id")
      #
      # @return [Schematic::Billing::Types::DeleteBillingCustomerResponse]
      def delete_billing_customer(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/customer/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeleteBillingCustomerResponse.load(response.body)
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
      # @example
      #   client.billing.upsert_billing_customer(
      #     email: "email",
      #     external_id: "external_id",
      #     meta: {
      #       key: "value"
      #     },
      #     name: "name"
      #   )
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
      # @example
      #   client.billing.list_customers_with_subscriptions(
      #     company_ids: ["company_ids"],
      #     name: "name",
      #     provider_type: "metronome",
      #     q: "q",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListCustomersWithSubscriptionsResponse]
      def list_customers_with_subscriptions(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.count_customers(
      #     company_ids: ["company_ids"],
      #     name: "name",
      #     provider_type: "metronome",
      #     q: "q",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::CountCustomersResponse]
      def count_customers(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_ids"] = params[:company_ids] if params.key?(:company_ids)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.list_invoices(
      #     company_id: "company_id",
      #     customer_external_id: "customer_external_id",
      #     subscription_external_id: "subscription_external_id",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListInvoicesResponse]
      def list_invoices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["customer_external_id"] = params[:customer_external_id] if params.key?(:customer_external_id)
        query_params["subscription_external_id"] = params[:subscription_external_id] if params.key?(:subscription_external_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.upsert_invoice(
      #     amount_due: 1000000,
      #     amount_paid: 1000000,
      #     amount_remaining: 1000000,
      #     collection_method: "collection_method",
      #     currency: "currency",
      #     customer_external_id: "customer_external_id",
      #     subtotal: 1000000
      #   )
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
      # @option params [String] :billing_id
      #
      # @example
      #   client.billing.delete_billing_invoice(billing_id: "billing_id")
      #
      # @return [Schematic::Billing::Types::DeleteBillingInvoiceResponse]
      def delete_billing_invoice(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/invoices/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeleteBillingInvoiceResponse.load(response.body)
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
      # @example
      #   client.billing.list_meters(
      #     display_name: "display_name",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListMetersResponse]
      def list_meters(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["display_name"] = params[:display_name] if params.key?(:display_name)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.upsert_billing_meter(
      #     display_name: "display_name",
      #     event_name: "event_name",
      #     event_payload_key: "event_payload_key",
      #     external_id: "external_id"
      #   )
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
      # @example
      #   client.billing.list_payment_methods(
      #     company_id: "company_id",
      #     customer_external_id: "customer_external_id",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListPaymentMethodsResponse]
      def list_payment_methods(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["customer_external_id"] = params[:customer_external_id] if params.key?(:customer_external_id)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @example
      #   client.billing.upsert_payment_method(
      #     customer_external_id: "customer_external_id",
      #     external_id: "external_id",
      #     payment_method_type: "payment_method_type"
      #   )
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
      # @option params [String] :billing_id
      #
      # @example
      #   client.billing.delete_payment_method_by_external_id(billing_id: "billing_id")
      #
      # @return [Schematic::Billing::Types::DeletePaymentMethodByExternalIdResponse]
      def delete_payment_method_by_external_id(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "DELETE",
          path: "billing/payment-methods/#{URI.encode_uri_component(params[:billing_id].to_s)}",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Billing::Types::DeletePaymentMethodByExternalIdResponse.load(response.body)
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
      # @option params [Integer, nil] :interval_count
      # @option params [Boolean, nil] :is_active
      # @option params [String, nil] :plan_version_id
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
      # @example
      #   client.billing.list_billing_prices(
      #     currency: "currency",
      #     for_initial_plan: true,
      #     for_trial_expiry_plan: true,
      #     ids: ["ids"],
      #     interval: "interval",
      #     interval_count: 1000000,
      #     is_active: true,
      #     plan_version_id: "plan_version_id",
      #     price: 1000000,
      #     product_id: "product_id",
      #     product_ids: ["product_ids"],
      #     provider_type: "metronome",
      #     q: "q",
      #     tiers_mode: "graduated",
      #     usage_type: "licensed",
      #     with_meter: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListBillingPricesResponse]
      def list_billing_prices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["currency"] = params[:currency] if params.key?(:currency)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["interval"] = params[:interval] if params.key?(:interval)
        query_params["interval_count"] = params[:interval_count] if params.key?(:interval_count)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
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
      # @example
      #   client.billing.upsert_billing_price(
      #     billing_scheme: "per_unit",
      #     currency: "currency",
      #     external_account_id: "external_account_id",
      #     interval: "interval",
      #     is_active: true,
      #     price: 1000000,
      #     price_external_id: "price_external_id",
      #     price_tiers: [{
      #       price_external_id: "price_external_id"
      #     }],
      #     product_external_id: "product_external_id",
      #     usage_type: "licensed"
      #   )
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
      # @example
      #   client.billing.delete_billing_product(billing_id: "billing_id")
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
      # @option params [Integer, nil] :interval_count
      # @option params [Boolean, nil] :is_active
      # @option params [String, nil] :plan_version_id
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
      # @example
      #   client.billing.list_billing_product_prices(
      #     currency: "currency",
      #     for_initial_plan: true,
      #     for_trial_expiry_plan: true,
      #     ids: ["ids"],
      #     interval: "interval",
      #     interval_count: 1000000,
      #     is_active: true,
      #     plan_version_id: "plan_version_id",
      #     price: 1000000,
      #     product_id: "product_id",
      #     product_ids: ["product_ids"],
      #     provider_type: "metronome",
      #     q: "q",
      #     tiers_mode: "graduated",
      #     usage_type: "licensed",
      #     with_meter: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListBillingProductPricesResponse]
      def list_billing_product_prices(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["currency"] = params[:currency] if params.key?(:currency)
        query_params["for_initial_plan"] = params[:for_initial_plan] if params.key?(:for_initial_plan)
        query_params["for_trial_expiry_plan"] = params[:for_trial_expiry_plan] if params.key?(:for_trial_expiry_plan)
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["interval"] = params[:interval] if params.key?(:interval)
        query_params["interval_count"] = params[:interval_count] if params.key?(:interval_count)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["plan_version_id"] = params[:plan_version_id] if params.key?(:plan_version_id)
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
      # @example
      #   client.billing.delete_product_price(billing_id: "billing_id")
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
      # @example
      #   client.billing.upsert_billing_product(
      #     external_id: "external_id",
      #     price: 1.1
      #   )
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
      # @option params [Boolean, nil] :recurring_charges_only
      # @option params [Boolean, nil] :with_one_time_charges
      # @option params [Boolean, nil] :with_prices_only
      # @option params [Boolean, nil] :with_zero_price
      # @option params [Boolean, nil] :without_linked_to_plan
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.billing.list_billing_products(
      #     ids: ["ids"],
      #     is_active: true,
      #     name: "name",
      #     price_usage_type: "licensed",
      #     provider_type: "metronome",
      #     q: "q",
      #     recurring_charges_only: true,
      #     with_one_time_charges: true,
      #     with_prices_only: true,
      #     with_zero_price: true,
      #     without_linked_to_plan: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListBillingProductsResponse]
      def list_billing_products(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["price_usage_type"] = params[:price_usage_type] if params.key?(:price_usage_type)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["recurring_charges_only"] = params[:recurring_charges_only] if params.key?(:recurring_charges_only)
        query_params["with_one_time_charges"] = params[:with_one_time_charges] if params.key?(:with_one_time_charges)
        query_params["with_prices_only"] = params[:with_prices_only] if params.key?(:with_prices_only)
        query_params["with_zero_price"] = params[:with_zero_price] if params.key?(:with_zero_price)
        query_params["without_linked_to_plan"] = params[:without_linked_to_plan] if params.key?(:without_linked_to_plan)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @option params [Boolean, nil] :recurring_charges_only
      # @option params [Boolean, nil] :with_one_time_charges
      # @option params [Boolean, nil] :with_prices_only
      # @option params [Boolean, nil] :with_zero_price
      # @option params [Boolean, nil] :without_linked_to_plan
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.billing.count_billing_products(
      #     ids: ["ids"],
      #     is_active: true,
      #     name: "name",
      #     price_usage_type: "licensed",
      #     provider_type: "metronome",
      #     q: "q",
      #     recurring_charges_only: true,
      #     with_one_time_charges: true,
      #     with_prices_only: true,
      #     with_zero_price: true,
      #     without_linked_to_plan: true,
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::CountBillingProductsResponse]
      def count_billing_products(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ids"] = params[:ids] if params.key?(:ids)
        query_params["is_active"] = params[:is_active] if params.key?(:is_active)
        query_params["name"] = params[:name] if params.key?(:name)
        query_params["price_usage_type"] = params[:price_usage_type] if params.key?(:price_usage_type)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["q"] = params[:q] if params.key?(:q)
        query_params["recurring_charges_only"] = params[:recurring_charges_only] if params.key?(:recurring_charges_only)
        query_params["with_one_time_charges"] = params[:with_one_time_charges] if params.key?(:with_one_time_charges)
        query_params["with_prices_only"] = params[:with_prices_only] if params.key?(:with_prices_only)
        query_params["with_zero_price"] = params[:with_zero_price] if params.key?(:with_zero_price)
        query_params["without_linked_to_plan"] = params[:without_linked_to_plan] if params.key?(:without_linked_to_plan)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

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
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :company_id
      # @option params [Boolean, nil] :is_default
      # @option params [Schematic::Types::BillingProviderType, nil] :provider_type
      # @option params [Integer, nil] :limit
      # @option params [Integer, nil] :offset
      #
      # @example
      #   client.billing.list_company_billing_profiles(
      #     company_id: "company_id",
      #     is_default: true,
      #     provider_type: "metronome",
      #     limit: 1000000,
      #     offset: 1000000
      #   )
      #
      # @return [Schematic::Billing::Types::ListCompanyBillingProfilesResponse]
      def list_company_billing_profiles(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["company_id"] = params[:company_id] if params.key?(:company_id)
        query_params["is_default"] = params[:is_default] if params.key?(:is_default)
        query_params["provider_type"] = params[:provider_type] if params.key?(:provider_type)
        query_params["limit"] = params[:limit] if params.key?(:limit)
        query_params["offset"] = params[:offset] if params.key?(:offset)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "billing/profiles",
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
          Schematic::Billing::Types::ListCompanyBillingProfilesResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Billing::Types::UpdateCompanyBillingProfileRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :billing_profile_id
      #
      # @example
      #   client.billing.update_company_billing_profile(
      #     billing_profile_id: "billing_profile_id",
      #     collection_method: "charge_automatically"
      #   )
      #
      # @return [Schematic::Billing::Types::UpdateCompanyBillingProfileResponse]
      def update_company_billing_profile(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Billing::Types::UpdateCompanyBillingProfileRequestBody.new(params).to_h
        non_body_param_names = %w[billing_profile_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "billing/profiles/#{URI.encode_uri_component(params[:billing_profile_id].to_s)}",
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
          Schematic::Billing::Types::UpdateCompanyBillingProfileResponse.load(response.body)
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
      # @example
      #   client.billing.upsert_billing_subscription(
      #     cancel_at_period_end: true,
      #     currency: "currency",
      #     customer_external_id: "customer_external_id",
      #     discounts: [{
      #       coupon_external_id: "coupon_external_id",
      #       external_id: "external_id",
      #       is_active: true,
      #       started_at: "2024-01-15T09:30:00Z"
      #     }],
      #     expired_at: "2024-01-15T09:30:00Z",
      #     product_external_ids: [{
      #       currency: "currency",
      #       interval: "interval",
      #       price: 1000000,
      #       price_external_id: "price_external_id",
      #       product_external_id: "product_external_id",
      #       quantity: 1000000,
      #       usage_type: "licensed"
      #     }],
      #     subscription_external_id: "subscription_external_id",
      #     total_price: 1000000
      #   )
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
