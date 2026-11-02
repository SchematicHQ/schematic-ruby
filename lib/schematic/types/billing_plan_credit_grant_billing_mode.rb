# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingPlanCreditGrantBillingMode
      extend Schematic::Internal::Types::Enum

      GRANTED = "granted"
      BILLED = "billed"
    end
  end
end
