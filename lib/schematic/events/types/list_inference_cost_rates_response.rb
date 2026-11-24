# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      class ListInferenceCostRatesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::InferenceCostRateResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Events::Types::ListInferenceCostRatesParams }, optional: false, nullable: false
      end
    end
  end
end
