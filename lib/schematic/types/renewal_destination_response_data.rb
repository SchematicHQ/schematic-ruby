# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class RenewalDestinationResponseData < Internal::Types::Model
      field :billing_period, -> { Schematic::Types::PlanPriceCadence }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
