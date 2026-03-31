# frozen_string_literal: true

module Schematic
  module Types
    class BillingCreditView < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :burn_strategy, -> { Schematic::Types::BillingCreditBurnStrategy }, optional: false, nullable: false
      field :cost_editable, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :default_expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: false, nullable: false
      field :default_expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :default_rollover_policy, -> { Schematic::Types::BillingCreditRolloverPolicy }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :icon, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plural_name, -> { String }, optional: true, nullable: false
      field :price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :price_per_unit, -> { Integer }, optional: true, nullable: false
      field :price_per_unit_decimal, -> { String }, optional: true, nullable: false
      field :product, -> { Schematic::Types::BillingProductResponseData }, optional: true, nullable: false
      field :singular_name, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
