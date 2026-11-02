# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyInferenceCostResponseData < Internal::Types::Model
      field :by_model, -> { Internal::Types::Array[Schematic::Types::InferenceModelCostResponseData] }, optional: false, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :costs, -> { Internal::Types::Array[Schematic::Types::InferenceCostAmountResponseData] }, optional: false, nullable: false

      field :end_time, -> { String }, optional: false, nullable: false

      field :event_count, -> { Integer }, optional: false, nullable: false

      field :start_time, -> { String }, optional: false, nullable: false

      field :unpriced_event_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
