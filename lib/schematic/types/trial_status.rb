# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module TrialStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      CONVERTED = "converted"
      EXPIRED = "expired"
    end
  end
end
