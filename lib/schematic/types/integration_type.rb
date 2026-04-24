# frozen_string_literal: true

module Schematic
  module Types
    module IntegrationType
      extend Schematic::Internal::Types::Enum

      CLERK = "clerk"
      ORB = "orb"
      STRIPE = "stripe"
      UNKNOWN = "unknown"
    end
  end
end
