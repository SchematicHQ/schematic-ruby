# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CompanyPlanInvalidReason
      extend Schematic::Internal::Types::Enum

      DOWNGRADE_NOT_PERMITTED = "downgrade_not_permitted"
      FEATURE_USAGE_EXCEEDED = "feature_usage_exceeded"
    end
  end
end
