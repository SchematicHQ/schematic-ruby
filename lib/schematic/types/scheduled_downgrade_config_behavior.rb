# frozen_string_literal: true

module Schematic
  module Types
    module ScheduledDowngradeConfigBehavior
      extend Schematic::Internal::Types::Enum

      END_OF_BILLING_PERIOD = "end_of_billing_period"
      NONE = "none"
    end
  end
end
