# frozen_string_literal: true

module Schematic
  module Types
    class CreateBillingPriceTierRequestBody < Internal::Types::Model
      field :flat_amount, -> { Integer }, optional: true, nullable: false
      field :per_unit_decimal, -> { String }, optional: true, nullable: false
      field :per_unit_price, -> { Integer }, optional: true, nullable: false
      field :price_external_id, -> { String }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
      field :up_to, -> { Integer }, optional: true, nullable: false
    end
  end
end
