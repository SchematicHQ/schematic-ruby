# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module InferenceCostSource
      extend Schematic::Internal::Types::Enum

      LIST_PRICE = "list_price"
      PROVIDED = "provided"
      UNPRICED = "unpriced"
    end
  end
end
