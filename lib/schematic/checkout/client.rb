# frozen_string_literal: true

module Schematic
  module Checkout
    class Client
      # @param client [Schematic::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::ChangeSubscriptionInternalRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.internal(
      #     add_on_ids: [{
      #       add_on_id: "add_on_id",
      #       price_id: "price_id"
      #     }],
      #     auto_topup_overrides: [{
      #       plan_credit_grant_id: "plan_credit_grant_id"
      #     }],
      #     company_id: "company_id",
      #     credit_bundles: [{
      #       bundle_id: "bundle_id",
      #       quantity: 1000000
      #     }],
      #     custom_field_values: [{
      #       id: "id",
      #       value: "value"
      #     }],
      #     new_plan_id: "new_plan_id",
      #     new_price_id: "new_price_id",
      #     pay_in_advance: [{
      #       price_id: "price_id",
      #       quantity: 1000000
      #     }],
      #     skip_trial: true
      #   )
      #
      # @return [Schematic::Checkout::Types::CheckoutInternalResponse]
      def internal(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "checkout-internal",
          body: Schematic::Types::ChangeSubscriptionInternalRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::CheckoutInternalResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Checkout::Types::CheckoutDataRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.get_checkout_data(company_id: "company_id")
      #
      # @return [Schematic::Checkout::Types::GetCheckoutDataResponse]
      def get_checkout_data(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "checkout-internal/data",
          body: Schematic::Checkout::Types::CheckoutDataRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::GetCheckoutDataResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::ChangeSubscriptionInternalRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.preview_checkout_internal(
      #     add_on_ids: [{
      #       add_on_id: "add_on_id",
      #       price_id: "price_id"
      #     }],
      #     auto_topup_overrides: [{
      #       plan_credit_grant_id: "plan_credit_grant_id"
      #     }],
      #     company_id: "company_id",
      #     credit_bundles: [{
      #       bundle_id: "bundle_id",
      #       quantity: 1000000
      #     }],
      #     custom_field_values: [{
      #       id: "id",
      #       value: "value"
      #     }],
      #     new_plan_id: "new_plan_id",
      #     new_price_id: "new_price_id",
      #     pay_in_advance: [{
      #       price_id: "price_id",
      #       quantity: 1000000
      #     }],
      #     skip_trial: true
      #   )
      #
      # @return [Schematic::Checkout::Types::PreviewCheckoutInternalResponse]
      def preview_checkout_internal(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "checkout-internal/preview",
          body: Schematic::Types::ChangeSubscriptionInternalRequestBody.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::PreviewCheckoutInternalResponse.load(response.body)
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
      #   client.checkout.get_company_billing_details(company_id: "company_id")
      #
      # @return [Schematic::Checkout::Types::GetCompanyBillingDetailsResponse]
      def get_company_billing_details(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "companies/#{URI.encode_uri_component(params[:company_id].to_s)}/billing-details",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::GetCompanyBillingDetailsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Checkout::Types::UpdateCompanyBillingDetailsRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :company_id
      #
      # @example
      #   client.checkout.update_company_billing_details(
      #     company_id: "company_id",
      #     values: [{
      #       id: "id",
      #       value: "value"
      #     }]
      #   )
      #
      # @return [Schematic::Checkout::Types::UpdateCompanyBillingDetailsResponse]
      def update_company_billing_details(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Checkout::Types::UpdateCompanyBillingDetailsRequestBody.new(params).to_h
        non_body_param_names = %w[company_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "companies/#{URI.encode_uri_component(params[:company_id].to_s)}/billing-details",
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
          Schematic::Checkout::Types::UpdateCompanyBillingDetailsResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::ManagePlanRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.manage_plan(
      #     add_on_selections: [{
      #       plan_id: "plan_id"
      #     }],
      #     company_id: "company_id",
      #     credit_bundles: [{
      #       bundle_id: "bundle_id",
      #       quantity: 1000000
      #     }],
      #     custom_field_values: [{
      #       id: "id",
      #       value: "value"
      #     }],
      #     pay_in_advance_entitlements: [{
      #       price_id: "price_id",
      #       quantity: 1000000
      #     }]
      #   )
      #
      # @return [Schematic::Checkout::Types::ManagePlanResponse]
      def manage_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "manage-plan",
          body: Schematic::Types::ManagePlanRequest.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::ManagePlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Types::ManagePlanRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.preview_manage_plan(
      #     add_on_selections: [{
      #       plan_id: "plan_id"
      #     }],
      #     company_id: "company_id",
      #     credit_bundles: [{
      #       bundle_id: "bundle_id",
      #       quantity: 1000000
      #     }],
      #     custom_field_values: [{
      #       id: "id",
      #       value: "value"
      #     }],
      #     pay_in_advance_entitlements: [{
      #       price_id: "price_id",
      #       quantity: 1000000
      #     }]
      #   )
      #
      # @return [Schematic::Checkout::Types::PreviewManagePlanResponse]
      def preview_manage_plan(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "manage-plan/preview",
          body: Schematic::Types::ManagePlanRequest.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::PreviewManagePlanResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Checkout::Types::CancelSubscriptionRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.checkout.cancel_subscription(company_id: "company_id")
      #
      # @return [Schematic::Checkout::Types::CancelSubscriptionResponse]
      def cancel_subscription(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "manage-plan/subscription/cancel",
          body: Schematic::Checkout::Types::CancelSubscriptionRequest.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise Schematic::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          Schematic::Checkout::Types::CancelSubscriptionResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Schematic::Checkout::Types::UpdateTrialEndRequestBody]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :subscription_id
      #
      # @example
      #   client.checkout.update_customer_subscription_trial_end(subscription_id: "subscription_id")
      #
      # @return [Schematic::Checkout::Types::UpdateCustomerSubscriptionTrialEndResponse]
      def update_customer_subscription_trial_end(request_options: {}, **params)
        params = Schematic::Internal::Types::Utils.normalize_keys(params)
        request_data = Schematic::Checkout::Types::UpdateTrialEndRequestBody.new(params).to_h
        non_body_param_names = %w[subscription_id]
        body = request_data.except(*non_body_param_names)

        request = Schematic::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "subscription/#{URI.encode_uri_component(params[:subscription_id].to_s)}/edit-trial-end",
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
          Schematic::Checkout::Types::UpdateCustomerSubscriptionTrialEndResponse.load(response.body)
        else
          error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
