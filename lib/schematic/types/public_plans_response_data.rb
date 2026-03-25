# frozen_string_literal: true

module Schematic
  module Types
    class PublicPlansResponseData < Internal::Types::Model
      field :active_add_ons, -> { Internal::Types::Array[Schematic::Types::PlanViewPublicResponseData] }, optional: false, nullable: false
      field :active_plans, -> { Internal::Types::Array[Schematic::Types::PlanViewPublicResponseData] }, optional: false, nullable: false
      field :add_on_compatibilities, -> { Internal::Types::Array[Schematic::Types::CompatiblePlans] }, optional: false, nullable: false
      field :capabilities, -> { Schematic::Types::ComponentCapabilities }, optional: true, nullable: false
      field :display_settings, -> { Schematic::Types::ComponentDisplaySettings }, optional: false, nullable: false
      field :show_as_monthly_prices, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_credits, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_period_toggle, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_zero_price_as_free, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
