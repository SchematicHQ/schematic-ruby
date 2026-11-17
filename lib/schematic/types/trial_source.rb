# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module TrialSource
      extend Schematic::Internal::Types::Enum

      API = "api"
      CUSTOM_PLAN = "custom_plan"
      SUBSCRIPTION = "subscription"
    end
  end
end
