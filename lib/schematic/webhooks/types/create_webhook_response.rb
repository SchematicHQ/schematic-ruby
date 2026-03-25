# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class CreateWebhookResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::WebhookResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
