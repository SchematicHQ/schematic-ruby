# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetCreditSpendPolicyUsageRequest < Internal::Types::Model
        field :billing_credit_id, -> { String }, optional: true, nullable: false

        field :company_id, -> { String }, optional: false, nullable: false

        field :user_ids, -> { String }, optional: true, nullable: false
      end
    end
  end
end
