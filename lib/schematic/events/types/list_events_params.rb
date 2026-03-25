# frozen_string_literal: true

module Schematic
  module Events
    module Types
      # Input parameters
      class ListEventsParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :event_subtype, -> { String }, optional: true, nullable: false
        field :event_types, -> { Internal::Types::Array[Schematic::Types::EventType] }, optional: true, nullable: false
        field :flag_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :user_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
