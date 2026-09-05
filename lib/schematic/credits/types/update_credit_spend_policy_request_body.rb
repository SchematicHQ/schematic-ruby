# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class UpdateCreditSpendPolicyRequestBody < Internal::Types::Model
        field :spend_policy_id, -> { String }, optional: false, nullable: false

        field :label, -> { String }, optional: true, nullable: false

        field :max_per_draw, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
