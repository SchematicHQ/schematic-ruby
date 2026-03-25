# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class CountWebhookEventsRequest < Internal::Types::Model
        field :ids, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :webhook_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
