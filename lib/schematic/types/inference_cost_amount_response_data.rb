# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class InferenceCostAmountResponseData < Internal::Types::Model
      field :cost, -> { String }, optional: false, nullable: false

      field :currency, -> { String }, optional: false, nullable: false

      field :event_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
