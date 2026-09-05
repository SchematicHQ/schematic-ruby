# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CountCreditSpendPoliciesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::CountCreditSpendPoliciesParams }, optional: false, nullable: false
      end
    end
  end
end
