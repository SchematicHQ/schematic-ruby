# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class CreateEventResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::RawEventResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
