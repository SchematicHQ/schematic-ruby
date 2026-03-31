# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditRolloverPolicy
      extend Schematic::Internal::Types::Enum

      EXPIRE = "expire"
      NONE = "none"
      ROLLOVER = "rollover"
    end
  end
end
