# frozen_string_literal: true

module Schematic
  module Types
    class WebhookResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit_trigger_configs, -> { Internal::Types::Array[Schematic::Types::CreditTriggerConfig] }, optional: true, nullable: false
      field :entitlement_trigger_configs, -> { Internal::Types::Array[Schematic::Types::EntitlementTriggerConfig] }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :request_types, -> { Internal::Types::Array[Schematic::Types::WebhookRequestType] }, optional: false, nullable: false
      field :secret, -> { String }, optional: false, nullable: false
      field :status, -> { Schematic::Types::WebhookStatus }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :url, -> { String }, optional: false, nullable: false
    end
  end
end
