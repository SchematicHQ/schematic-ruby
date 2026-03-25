# frozen_string_literal: true

module Schematic
  module Types
    module BillingPriceScheme
      extend Schematic::Internal::Types::Enum

      PER_UNIT = "per_unit"
      TIERED = "tiered"
    end
  end
end
