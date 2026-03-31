# frozen_string_literal: true

module Schematic
  module Types
    class CheckFlagsBulkResponseData < Internal::Types::Model
      field :data, -> { Internal::Types::Array[Schematic::Types::CheckFlagsResponseData] }, optional: false, nullable: false
    end
  end
end
