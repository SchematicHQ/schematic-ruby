# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingCreditAutoTopupAvailability
      extend Schematic::Internal::Types::Enum

      OFF = "off"
      AUTOMATIC = "automatic"
      USER_CONTROLLED = "user_controlled"
    end
  end
end
