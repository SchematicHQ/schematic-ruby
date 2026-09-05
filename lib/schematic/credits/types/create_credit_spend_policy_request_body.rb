# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CreateCreditSpendPolicyRequestBody < Internal::Types::Model
        field :billing_credit_id, -> { String }, optional: false, nullable: false

        field :company_id, -> { String }, optional: true, nullable: false

        field :label, -> { String }, optional: true, nullable: false

        field :max_per_draw, -> { Integer }, optional: false, nullable: false

        field :user_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
