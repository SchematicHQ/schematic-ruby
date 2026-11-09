# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class ResumeSubscriptionRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false

        field :subscription_external_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
