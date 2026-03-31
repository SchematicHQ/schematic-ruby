# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CountBillingProductsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::CountBillingProductsParams }, optional: false, nullable: false
      end
    end
  end
end
