# frozen_string_literal: true

module Schematic
  module Types
    class CaptureRawEventBatch < Internal::Types::Model
      field :events, -> { Internal::Types::Array[Schematic::Types::CaptureRawEvent] }, optional: false, nullable: false
    end
  end
end
