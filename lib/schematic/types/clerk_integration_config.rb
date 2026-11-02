# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ClerkIntegrationConfig < Internal::Types::Model
      field :first_events_received, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :webhook_url, -> { String }, optional: true, nullable: false
    end
  end
end
