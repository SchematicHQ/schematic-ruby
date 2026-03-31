# frozen_string_literal: true

module Schematic
  module Types
    class EventBodyTrack < Internal::Types::Model
      field :company, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :event, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :user, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
    end
  end
end
