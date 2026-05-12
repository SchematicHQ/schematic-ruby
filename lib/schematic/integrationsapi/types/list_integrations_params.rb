# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      # Input parameters
      class ListIntegrationsParams < Internal::Types::Model
        field :billing_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :exclude_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :state, -> { Schematic::Types::IntegrationState }, optional: true, nullable: false
        field :type, -> { Schematic::Types::IntegrationType }, optional: true, nullable: false
      end
    end
  end
end
