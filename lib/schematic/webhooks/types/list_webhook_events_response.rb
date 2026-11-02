# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Webhooks
    module Types
      class ListWebhookEventsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::WebhookEventDetailResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Webhooks::Types::ListWebhookEventsParams }, optional: false, nullable: false
      end
    end
  end
end
