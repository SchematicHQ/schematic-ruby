# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CheckFlagsBulkResponseData < Internal::Types::Model
      field :data, -> { Internal::Types::Array[Schematic::Types::CheckFlagsResponseData] }, optional: false, nullable: false
    end
  end
end
