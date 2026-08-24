# frozen_string_literal: true

module Schematic
  module Types
    class IntegrationsListResponseData < Internal::Types::Model
      field :capabilities, -> { Schematic::Types::IntegrationCapabilities }, optional: false, nullable: false

      field :config, -> { Schematic::Types::IntegrationConfig }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :is_app_install, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :is_connect_install, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :last_webhook_received_at, -> { String }, optional: true, nullable: false

      field :state, -> { Schematic::Types::IntegrationState }, optional: false, nullable: false

      field :type, -> { Schematic::Types::IntegrationType }, optional: false, nullable: false
    end
  end
end
