# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module InferenceCostRateScope
      extend Schematic::Internal::Types::Enum

      ACCOUNT = "account"
      LIST_PRICE = "list_price"
    end
  end
end
