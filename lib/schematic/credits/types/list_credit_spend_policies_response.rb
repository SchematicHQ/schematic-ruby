# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListCreditSpendPoliciesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CreditSpendPolicyResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::ListCreditSpendPoliciesParams }, optional: false, nullable: false
      end
    end
  end
end
