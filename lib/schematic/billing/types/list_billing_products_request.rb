# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListBillingProductsRequest < Internal::Types::Model
        field :ids, -> { String }, optional: true, nullable: false
        field :is_active, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :price_usage_type, -> { Schematic::Types::BillingPriceUsageType }, optional: true, nullable: false
        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :with_one_time_charges, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :with_prices_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :with_zero_price, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :without_linked_to_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
