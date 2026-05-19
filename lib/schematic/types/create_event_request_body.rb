# frozen_string_literal: true

module Schematic
  module Types
    class CreateEventRequestBody < Internal::Types::Model
      field :backfill, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :body, -> { Schematic::Types::EventBody }, optional: true, nullable: false
      field :event_type, -> { Schematic::Types::EventType }, optional: false, nullable: false
      field :idempotency_key, -> { String }, optional: true, nullable: false
      field :sent_at, -> { String }, optional: true, nullable: false
      field :trusted_client_clock, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
