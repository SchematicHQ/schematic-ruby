# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CaptureRawEventBatch < Internal::Types::Model
      field :events, -> { Internal::Types::Array[Schematic::Types::CaptureRawEvent] }, optional: false, nullable: false
    end
  end
end
