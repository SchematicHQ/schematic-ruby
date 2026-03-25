# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CreateCreditBundleRequestBody < Internal::Types::Model
        field :bundle_name, -> { String }, optional: false, nullable: false
        field :bundle_type, -> { String }, optional: true, nullable: false
        field :credit_id, -> { String }, optional: false, nullable: false
        field :currency, -> { String }, optional: false, nullable: false
        field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
        field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
        field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
        field :price_per_unit, -> { Integer }, optional: false, nullable: false
        field :price_per_unit_decimal, -> { String }, optional: true, nullable: false
        field :quantity, -> { Integer }, optional: true, nullable: false
        field :status, -> { Schematic::Types::BillingCreditBundleStatus }, optional: true, nullable: false
      end
    end
  end
end
