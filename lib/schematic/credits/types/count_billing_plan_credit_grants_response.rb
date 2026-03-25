# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CountBillingPlanCreditGrantsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Credits::Types::CountBillingPlanCreditGrantsParams }, optional: false, nullable: false
      end
    end
  end
end
