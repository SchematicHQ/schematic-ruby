# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class UpdateTrialEndRequestBody < Internal::Types::Model
        field :subscription_id, -> { String }, optional: false, nullable: false
        field :trial_end, -> { String }, optional: true, nullable: false
      end
    end
  end
end
