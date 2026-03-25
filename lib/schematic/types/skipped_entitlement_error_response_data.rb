# frozen_string_literal: true

module Schematic
  module Types
    class SkippedEntitlementErrorResponseData < Internal::Types::Model
      field :message, -> { String }, optional: false, nullable: false
    end
  end
end
