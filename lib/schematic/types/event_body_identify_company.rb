# frozen_string_literal: true

module Schematic
  module Types
    # Information about the company associated with the user; required only if it is a new user
    class EventBodyIdentifyCompany < Internal::Types::Model
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
    end
  end
end
