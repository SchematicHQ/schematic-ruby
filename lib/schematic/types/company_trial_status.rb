# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CompanyTrialStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      CANCELED = "canceled"
      CONVERTED = "converted"
      EXPIRED = "expired"
    end
  end
end
