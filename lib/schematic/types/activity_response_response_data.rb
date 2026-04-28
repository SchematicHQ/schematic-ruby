# frozen_string_literal: true

module Schematic
  module Types
    class ActivityResponseResponseData < Internal::Types::Model
      field :entries, -> { Internal::Types::Array[Schematic::Types::ActivityEntryResponseData] }, optional: false, nullable: false
    end
  end
end
