# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class IntegrationsDataSetResponseData < Internal::Types::Model
      field :keys, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
