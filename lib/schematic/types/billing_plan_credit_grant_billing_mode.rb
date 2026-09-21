# frozen_string_literal: true

module Schematic
  module Types
    module BillingPlanCreditGrantBillingMode
      extend Schematic::Internal::Types::Enum

      GRANTED = "granted"
      BILLED = "billed"
    end
  end
end
