# frozen_string_literal: true

module Schematic
  module Events
    module Types
      # Input parameters
      class GetEventSummariesParams < Internal::Types::Model
        field :event_subtypes, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
