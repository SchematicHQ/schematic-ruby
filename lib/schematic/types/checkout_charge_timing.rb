# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CheckoutChargeTiming
      extend Schematic::Internal::Types::Enum

      AT_RENEWAL = "at_renewal"
      NONE = "none"
      NOW = "now"
    end
  end
end
