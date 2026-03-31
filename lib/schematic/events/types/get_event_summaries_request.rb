# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class GetEventSummariesRequest < Internal::Types::Model
        field :q, -> { String }, optional: true, nullable: false
        field :event_subtypes, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
