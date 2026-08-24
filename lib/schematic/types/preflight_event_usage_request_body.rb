# frozen_string_literal: true

module Schematic
  module Types
    class PreflightEventUsageRequestBody < Internal::Types::Model
      field :event_subtype, -> { String }, optional: false, nullable: false

      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
