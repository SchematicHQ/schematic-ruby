# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EnvironmentUsagePointResponseData < Internal::Types::Model
      field :timestamp, -> { String }, optional: false, nullable: false

      field :usage, -> { Integer }, optional: false, nullable: false
    end
  end
end
