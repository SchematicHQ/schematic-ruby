# frozen_string_literal: true

module Schematic
  module Types
    class DataEventPayload < Internal::Types::Model
      field :api_key, -> { String }, optional: false, nullable: false
      field :body, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :sent_at, -> { String }, optional: true, nullable: false
      field :type, -> { Schematic::Types::EventType }, optional: false, nullable: false
    end
  end
end
