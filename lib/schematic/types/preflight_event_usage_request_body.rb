# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PreflightEventUsageRequestBody < Internal::Types::Model
      field :event_subtype, -> { String }, optional: false, nullable: false

      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
