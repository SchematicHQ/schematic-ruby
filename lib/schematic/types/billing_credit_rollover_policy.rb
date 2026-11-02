# frozen_string_literal: true

require_relative "../../schematic"

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
