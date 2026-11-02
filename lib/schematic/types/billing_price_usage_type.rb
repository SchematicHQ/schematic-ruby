# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingPriceUsageType
      extend Schematic::Internal::Types::Enum

      LICENSED = "licensed"
      METERED = "metered"
    end
  end
end
