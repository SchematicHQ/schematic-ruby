# frozen_string_literal: true

module Schematic
  module Types
    module CreditUsageReason
      extend Schematic::Internal::Types::Enum

      LEASE_HOLD = "lease_hold"
      LEASE_RELEASE = "lease_release"
      MANUAL_ADJUSTMENT = "manual_adjustment"
      RECONCILIATION = "reconciliation"
      TRACK = "track"
    end
  end
end
