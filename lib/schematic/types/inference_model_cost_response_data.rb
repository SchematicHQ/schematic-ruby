# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class InferenceModelCostResponseData < Internal::Types::Model
      field :costs, -> { Internal::Types::Array[Schematic::Types::InferenceCostAmountResponseData] }, optional: false, nullable: false

      field :event_count, -> { Integer }, optional: false, nullable: false

      field :provider, -> { String }, optional: false, nullable: false

      field :response_model, -> { String }, optional: false, nullable: false

      field :unpriced_event_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
