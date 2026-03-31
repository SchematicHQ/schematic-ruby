# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreateBillingCustomerRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :default_payment_method_id, -> { String }, optional: true, nullable: false
        field :email, -> { String }, optional: false, nullable: false
        field :external_id, -> { String }, optional: false, nullable: false
        field :meta, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
      end
    end
  end
end
