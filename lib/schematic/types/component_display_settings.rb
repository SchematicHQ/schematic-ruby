# frozen_string_literal: true

module Schematic
  module Types
    class ComponentDisplaySettings < Internal::Types::Model
      field :show_as_monthly_prices, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_credits, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_feature_description, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_hard_limit, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_period_toggle, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_zero_price_as_free, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
