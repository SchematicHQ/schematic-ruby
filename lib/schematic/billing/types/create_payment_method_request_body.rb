# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreatePaymentMethodRequestBody < Internal::Types::Model
        field :account_last_4, -> { String }, optional: true, nullable: false, api_name: "account_last4"
        field :account_name, -> { String }, optional: true, nullable: false
        field :bank_name, -> { String }, optional: true, nullable: false
        field :billing_email, -> { String }, optional: true, nullable: false
        field :billing_name, -> { String }, optional: true, nullable: false
        field :card_brand, -> { String }, optional: true, nullable: false
        field :card_exp_month, -> { Integer }, optional: true, nullable: false
        field :card_exp_year, -> { Integer }, optional: true, nullable: false
        field :card_last_4, -> { String }, optional: true, nullable: false, api_name: "card_last4"
        field :customer_external_id, -> { String }, optional: false, nullable: false
        field :external_id, -> { String }, optional: false, nullable: false
        field :payment_method_type, -> { String }, optional: false, nullable: false
      end
    end
  end
end
