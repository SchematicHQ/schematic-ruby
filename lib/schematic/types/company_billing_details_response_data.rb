# frozen_string_literal: true

module Schematic
  module Types
    class CompanyBillingDetailsResponseData < Internal::Types::Model
      field :address, -> { Schematic::Types::CompanyBillingAddressView }, optional: true, nullable: false
      field :checkout_settings, -> { Schematic::Types::CompanyBillingCheckoutSettings }, optional: false, nullable: false
      field :custom_fields, -> { Internal::Types::Array[Schematic::Types::CheckoutFieldWithValue] }, optional: false, nullable: false
      field :email, -> { String }, optional: true, nullable: false
      field :phone, -> { String }, optional: true, nullable: false
    end
  end
end
