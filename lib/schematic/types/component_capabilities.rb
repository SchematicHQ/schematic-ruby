# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ComponentCapabilities < Internal::Types::Model
      field :badge_visibility, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :checkout, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
