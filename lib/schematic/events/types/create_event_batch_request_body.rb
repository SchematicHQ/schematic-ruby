# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class CreateEventBatchRequestBody < Internal::Types::Model
        field :events, -> { Internal::Types::Array[Schematic::Types::CreateEventRequestBody] }, optional: false, nullable: false
      end
    end
  end
end
