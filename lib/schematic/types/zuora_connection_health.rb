# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ZuoraConnectionHealth < Internal::Types::Model
      field :checked_at, -> { String }, optional: false, nullable: false

      field :healthy, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :message, -> { String }, optional: true, nullable: false
    end
  end
end
