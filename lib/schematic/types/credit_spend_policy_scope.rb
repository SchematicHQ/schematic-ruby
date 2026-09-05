# frozen_string_literal: true

module Schematic
  module Types
    module CreditSpendPolicyScope
      extend Schematic::Internal::Types::Enum

      COMPANY = "company"
      USER = "user"
      GROUP = "group"
    end
  end
end
