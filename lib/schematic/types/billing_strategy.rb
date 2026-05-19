# frozen_string_literal: true

module Schematic
  module Types
    module BillingStrategy
      extend Schematic::Internal::Types::Enum

      SCHEMATIC_MANAGED = "schematic_managed"
      PROVIDER_MANAGED = "provider_managed"
      NO_BILLING = "no_billing"
    end
  end
end
