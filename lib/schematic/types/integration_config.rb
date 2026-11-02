# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class IntegrationConfig < Internal::Types::Model
      extend Schematic::Internal::Types::Union

      discriminant :type

      member -> { Schematic::Types::ClerkIntegrationConfig }, key: "CLERK"

      member -> { Schematic::Types::MetronomeIntegrationConfig }, key: "METRONOME"

      member -> { Schematic::Types::OrbIntegrationConfig }, key: "ORB"

      member -> { Schematic::Types::StripeIntegrationConfig }, key: "STRIPE"

      member -> { Schematic::Types::WorkOsIntegrationConfig }, key: "WORKOS"
    end
  end
end
