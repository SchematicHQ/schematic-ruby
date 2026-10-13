# frozen_string_literal: true

module Schematic
  module Types
    module CheckoutProblemSource
      extend Schematic::Internal::Types::Enum

      PROVIDER = "provider"
      REQUIREMENT = "requirement"
      VALIDATION = "validation"
    end
  end
end
