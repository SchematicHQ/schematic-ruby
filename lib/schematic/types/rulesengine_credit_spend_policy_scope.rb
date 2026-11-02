# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module RulesengineCreditSpendPolicyScope
      extend Schematic::Internal::Types::Enum

      COMPANY = "company"
      USER = "user"
      GROUP = "group"
    end
  end
end
