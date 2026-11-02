# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      class ListEventsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EventDetailResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Events::Types::ListEventsParams }, optional: false, nullable: false
      end
    end
  end
end
