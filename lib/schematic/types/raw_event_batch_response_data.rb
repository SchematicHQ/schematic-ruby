# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class RawEventBatchResponseData < Internal::Types::Model
      field :events, -> { Internal::Types::Array[Schematic::Types::RawEventResponseData] }, optional: false, nullable: false
    end
  end
end
