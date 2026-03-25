# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListBillingProductPricesRequest < Internal::Types::Model
        field :for_initial_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :for_trial_expiry_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :ids, -> { String }, optional: true, nullable: false
        field :interval, -> { String }, optional: true, nullable: false
        field :is_active, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :price, -> { Integer }, optional: true, nullable: false
        field :product_id, -> { String }, optional: true, nullable: false
        field :product_ids, -> { String }, optional: true, nullable: false
        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :tiers_mode, -> { Schematic::Types::BillingTiersMode }, optional: true, nullable: false
        field :usage_type, -> { Schematic::Types::BillingPriceUsageType }, optional: true, nullable: false
        field :with_meter, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
