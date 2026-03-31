# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class CreateWebhookRequestBody < Internal::Types::Model
        field :credit_trigger_configs, -> { Internal::Types::Array[Schematic::Types::CreditTriggerConfig] }, optional: true, nullable: false
        field :entitlement_trigger_configs, -> { Internal::Types::Array[Schematic::Types::EntitlementTriggerConfig] }, optional: true, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :request_types, -> { Internal::Types::Array[Schematic::Types::WebhookRequestType] }, optional: false, nullable: false
        field :url, -> { String }, optional: false, nullable: false
      end
    end
  end
end
