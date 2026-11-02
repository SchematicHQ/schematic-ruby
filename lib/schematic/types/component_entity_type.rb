# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ComponentEntityType
      extend Schematic::Internal::Types::Enum

      BILLING = "billing"
      ENTITLEMENT = "entitlement"
    end
  end
end
