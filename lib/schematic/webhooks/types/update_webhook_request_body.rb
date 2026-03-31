# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class UpdateWebhookRequestBody < Internal::Types::Model
        field :webhook_id, -> { String }, optional: false, nullable: false
        field :credit_trigger_configs, -> { Internal::Types::Array[Schematic::Types::CreditTriggerConfig] }, optional: true, nullable: false
        field :entitlement_trigger_configs, -> { Internal::Types::Array[Schematic::Types::EntitlementTriggerConfig] }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :request_types, -> { Internal::Types::Array[Schematic::Types::WebhookRequestType] }, optional: true, nullable: false
        field :status, -> { Schematic::Types::WebhookStatus }, optional: true, nullable: false
        field :url, -> { String }, optional: true, nullable: false
      end
    end
  end
end
