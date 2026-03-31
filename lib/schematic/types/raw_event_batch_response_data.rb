# frozen_string_literal: true

module Schematic
  module Types
    class RawEventBatchResponseData < Internal::Types::Model
      field :events, -> { Internal::Types::Array[Schematic::Types::RawEventResponseData] }, optional: false, nullable: false
    end
  end
end
