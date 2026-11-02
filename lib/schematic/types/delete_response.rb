# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class DeleteResponse < Internal::Types::Model
      field :deleted, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
