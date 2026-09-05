# frozen_string_literal: true

module Schematic
  module Types
    class StripeSandboxCountriesResponseData < Internal::Types::Model
      field :countries, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
