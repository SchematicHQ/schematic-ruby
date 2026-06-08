# frozen_string_literal: true

module Schematic
  module Types
    module BillingProviderType
      extend Schematic::Internal::Types::Enum

      METRONOME = "metronome"
      ORB = "orb"
      SCHEMATIC = "schematic"
      STRIPE = "stripe"
    end
  end
end
