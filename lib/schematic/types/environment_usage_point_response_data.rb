# frozen_string_literal: true

module Schematic
  module Types
    class EnvironmentUsagePointResponseData < Internal::Types::Model
      field :timestamp, -> { String }, optional: false, nullable: false
      field :usage, -> { Integer }, optional: false, nullable: false
    end
  end
end
