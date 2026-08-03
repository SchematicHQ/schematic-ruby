# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class UpdateCompanyBillingDetailsRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :address, -> { Schematic::Types::CustomerBillingAddress }, optional: true, nullable: false
        field :email, -> { String }, optional: true, nullable: false
        field :phone, -> { String }, optional: true, nullable: false
        field :tax_id, -> { Schematic::Types::TaxIdInput }, optional: true, nullable: false
        field :values, -> { Internal::Types::Array[Schematic::Types::CheckoutFieldValue] }, optional: false, nullable: false
      end
    end
  end
end
