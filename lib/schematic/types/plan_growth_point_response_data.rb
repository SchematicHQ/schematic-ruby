# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanGrowthPointResponseData < Internal::Types::Model
      field :month, -> { String }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false

      field :plan_name, -> { String }, optional: false, nullable: false

      field :subscribers, -> { Integer }, optional: false, nullable: false
    end
  end
end
