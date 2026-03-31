# frozen_string_literal: true

module Schematic
  module Types
    class LimitTimeSeriesPointResponseData < Internal::Types::Model
      field :effective_at, -> { String }, optional: false, nullable: false
      field :is_soft_limit, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :limit_source, -> { Schematic::Types::EntitlementType }, optional: false, nullable: false
      field :limit_value, -> { Integer }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: true, nullable: false
      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false
    end
  end
end
