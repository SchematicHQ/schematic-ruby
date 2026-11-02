# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CheckoutBundlePurchaseBehavior
      extend Schematic::Internal::Types::Enum

      INDIVIDUAL = "individual"
      QUANTITY = "quantity"
    end
  end
end
