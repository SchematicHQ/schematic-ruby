# frozen_string_literal: true

module Schematic
  module Types
    module TraitType
      extend Schematic::Internal::Types::Enum

      BOOLEAN = "boolean"
      CURRENCY = "currency"
      DATE = "date"
      NUMBER = "number"
      STRING = "string"
      URL = "url"
    end
  end
end
