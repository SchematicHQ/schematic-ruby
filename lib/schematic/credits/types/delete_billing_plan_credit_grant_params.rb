# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      # Input parameters
      class DeleteBillingPlanCreditGrantParams < Internal::Types::Model
        field :apply_to_existing, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
