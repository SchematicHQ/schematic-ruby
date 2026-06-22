# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class SendTestWebhookActionResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::TestWebhookResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
