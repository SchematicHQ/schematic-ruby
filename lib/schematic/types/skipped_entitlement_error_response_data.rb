# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class SkippedEntitlementErrorResponseData < Internal::Types::Model
      field :message, -> { String }, optional: false, nullable: false
    end
  end
end
