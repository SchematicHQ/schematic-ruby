# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class RenewalDestinationRequestBody < Internal::Types::Model
      field :billing_period, -> { Schematic::Types::PlanPriceCadence }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
