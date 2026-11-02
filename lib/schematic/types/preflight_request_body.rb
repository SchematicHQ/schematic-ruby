# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PreflightRequestBody < Internal::Types::Model
      field :credit_cost, -> { Internal::Types::Hash[String, Float] }, optional: true, nullable: false

      field :event_quantities, -> { Schematic::Types::PreflightEventQuantitiesRequestBody }, optional: true, nullable: false

      field :event_usage, -> { Schematic::Types::PreflightEventUsageRequestBody }, optional: true, nullable: false

      field :usage, -> { Integer }, optional: true, nullable: false
    end
  end
end
