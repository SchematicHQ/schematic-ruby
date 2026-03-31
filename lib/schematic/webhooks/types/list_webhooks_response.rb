# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class ListWebhooksResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::WebhookResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Webhooks::Types::ListWebhooksParams }, optional: false, nullable: false
      end
    end
  end
end
