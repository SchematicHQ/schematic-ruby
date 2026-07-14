# frozen_string_literal: true

module Schematic
  module Types
    module EventType
      extend Schematic::Internal::Types::Enum

      FLAG_CHECK = "flag_check"
      IDENTIFY = "identify"
      INFERENCE = "inference"
      TRACK = "track"
    end
  end
end
