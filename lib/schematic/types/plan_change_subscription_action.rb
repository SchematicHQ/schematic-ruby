# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanChangeSubscriptionAction
      extend Schematic::Internal::Types::Enum

      ADJUSTMENT = "adjustment"
      DOWNGRADE = "downgrade"
      INVALID = "invalid"
      SUBSCRIBE = "subscribe"
      UNSUBSCRIBE = "unsubscribe"
      UPGRADE = "upgrade"
      UPGRADE_TRIAL = "upgrade_trial"
    end
  end
end
