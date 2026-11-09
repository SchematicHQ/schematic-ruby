# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      class ListAccountInferenceCostRatesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::AccountInferenceCostRateResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Events::Types::ListAccountInferenceCostRatesParams }, optional: false, nullable: false
      end
    end
  end
end
