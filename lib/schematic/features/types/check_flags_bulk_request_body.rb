# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class CheckFlagsBulkRequestBody < Internal::Types::Model
        field :contexts, -> { Internal::Types::Array[Schematic::Types::CheckFlagRequestBody] }, optional: false, nullable: false
      end
    end
  end
end
