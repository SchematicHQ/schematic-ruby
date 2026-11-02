# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EventBody < Internal::Types::Model
      extend Schematic::Internal::Types::Union

      member -> { Schematic::Types::EventBodyInference }

      member -> { Schematic::Types::EventBodyFlagCheck }

      member -> { Schematic::Types::EventBodyTrack }

      member -> { Schematic::Types::EventBodyIdentify }
    end
  end
end
