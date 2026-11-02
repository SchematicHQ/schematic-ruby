# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingCreditBundleStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      INACTIVE = "inactive"
    end
  end
end
