# frozen_string_literal: true

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
