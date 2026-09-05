# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetCreditSpendPolicyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CreditSpendPolicyResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
