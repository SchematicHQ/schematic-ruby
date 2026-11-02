# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class StripeSandboxCountriesResponseData < Internal::Types::Model
      field :countries, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
