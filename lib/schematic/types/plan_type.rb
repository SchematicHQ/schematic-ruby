# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanType
      extend Schematic::Internal::Types::Enum

      PLAN = "plan"
      ADD_ON = "add_on"
    end
  end
end
