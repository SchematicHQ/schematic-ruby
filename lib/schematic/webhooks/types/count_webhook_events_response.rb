# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class CountWebhookEventsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Webhooks::Types::CountWebhookEventsParams }, optional: false, nullable: false
      end
    end
  end
end
