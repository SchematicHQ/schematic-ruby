# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanCreditGrantScaling
      extend Schematic::Internal::Types::Enum

      FIXED = "fixed"
      PER_LICENSE = "per_license"
    end
  end
end
