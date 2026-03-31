# frozen_string_literal: true

module Schematic
  module Types
    class WebhookEventResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :payload, -> { String }, optional: true, nullable: false
      field :request_type, -> { Schematic::Types::WebhookRequestType }, optional: false, nullable: false
      field :response_code, -> { Integer }, optional: true, nullable: false
      field :sent_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::WebhookEventStatus }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :webhook_id, -> { String }, optional: false, nullable: false
    end
  end
end
