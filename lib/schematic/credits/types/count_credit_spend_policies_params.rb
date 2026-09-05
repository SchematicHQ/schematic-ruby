# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      # Input parameters
      class CountCreditSpendPoliciesParams < Internal::Types::Model
        field :billing_credit_id, -> { String }, optional: true, nullable: false

        field :company_id, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :scope_type, -> { Schematic::Types::CreditSpendPolicyScope }, optional: true, nullable: false

        field :user_id, -> { String }, optional: true, nullable: false

        field :user_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
      end
    end
  end
end
