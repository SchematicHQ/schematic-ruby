# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class UpdateBillingCreditRequestBody < Internal::Types::Model
        field :credit_id, -> { String }, optional: false, nullable: false
        field :burn_strategy, -> { Schematic::Types::BillingCreditBurnStrategy }, optional: true, nullable: false
        field :default_expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
        field :default_expiry_unit_count, -> { Integer }, optional: true, nullable: false
        field :default_rollover_policy, -> { Schematic::Types::BillingCreditRolloverPolicy }, optional: true, nullable: false
        field :description, -> { String }, optional: false, nullable: false
        field :icon, -> { String }, optional: true, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :per_unit_price, -> { Integer }, optional: true, nullable: false
        field :per_unit_price_decimal, -> { String }, optional: true, nullable: false
        field :plural_name, -> { String }, optional: true, nullable: false
        field :singular_name, -> { String }, optional: true, nullable: false
      end
    end
  end
end
