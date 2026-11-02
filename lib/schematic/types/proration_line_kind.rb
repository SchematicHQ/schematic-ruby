# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ProrationLineKind
      extend Schematic::Internal::Types::Enum

      CHARGE = "charge"
      CREDIT = "credit"
    end
  end
end
