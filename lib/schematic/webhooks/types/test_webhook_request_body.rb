# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class TestWebhookRequestBody < Internal::Types::Model
        field :webhook_id, -> { String }, optional: false, nullable: false

        field :request_type, -> { Schematic::Types::WebhookRequestType }, optional: false, nullable: false
      end
    end
  end
end
