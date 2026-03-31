# frozen_string_literal: true

module Schematic
  module Types
    class CreateEventRequestBody < Internal::Types::Model
      field :body, -> { Schematic::Types::EventBody }, optional: true, nullable: false
      field :event_type, -> { Schematic::Types::EventType }, optional: false, nullable: false
      field :sent_at, -> { String }, optional: true, nullable: false
    end
  end
end
