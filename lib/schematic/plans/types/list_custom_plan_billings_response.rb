# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class ListCustomPlanBillingsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CustomPlanBillingResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::ListCustomPlanBillingsParams }, optional: false, nullable: false
      end
    end
  end
end
