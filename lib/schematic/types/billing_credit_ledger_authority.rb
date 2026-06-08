# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditLedgerAuthority
      extend Schematic::Internal::Types::Enum

      SCHEMATIC_AUTHORITATIVE = "schematic_authoritative"
      EXTERNAL_MIRROR = "external_mirror"
      EXTERNAL_RATED = "external_rated"
    end
  end
end
