# frozen_string_literal: true

module Schematic
  module Types
    module EntitlementValueType
      extend Schematic::Internal::Types::Enum

      BOOLEAN = "boolean"
      CREDIT = "credit"
      NUMERIC = "numeric"
      TRAIT = "trait"
      UNKNOWN = "unknown"
      UNLIMITED = "unlimited"
    end
  end
end
