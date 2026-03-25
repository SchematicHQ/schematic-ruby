# frozen_string_literal: true

module Schematic
  module Types
    class KeysRequestBody < Internal::Types::Model
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
    end
  end
end
