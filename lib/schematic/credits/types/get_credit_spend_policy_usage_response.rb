# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetCreditSpendPolicyUsageResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CreditSpendPolicyResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::GetCreditSpendPolicyUsageParams }, optional: false, nullable: false
      end
    end
  end
end
