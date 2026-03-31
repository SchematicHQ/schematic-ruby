# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class DeleteBillingPlanCreditGrantRequest < Internal::Types::Model
        field :plan_grant_id, -> { String }, optional: false, nullable: false
        field :apply_to_existing, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
