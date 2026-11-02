# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module IntegrationType
      extend Schematic::Internal::Types::Enum

      CLERK = "clerk"
      METRONOME = "metronome"
      ORB = "orb"
      STRIPE = "stripe"
      UNKNOWN = "unknown"
      WORKOS = "workos"
    end
  end
end
