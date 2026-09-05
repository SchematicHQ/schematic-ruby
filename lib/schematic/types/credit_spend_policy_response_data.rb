# frozen_string_literal: true

module Schematic
  module Types
    class CreditSpendPolicyResponseData < Internal::Types::Model
      field :billing_credit_id, -> { String }, optional: false, nullable: false

      field :company_id, -> { String }, optional: true, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :label, -> { String }, optional: true, nullable: false

      field :max_per_draw, -> { Integer }, optional: true, nullable: false

      field :scope_type, -> { Schematic::Types::CreditSpendPolicyScope }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false
    end
  end
end
