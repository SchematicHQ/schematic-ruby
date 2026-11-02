# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingSubscriptionTrialEndSetting
      extend Schematic::Internal::Types::Enum

      CANCEL = "cancel"
      SUBSCRIBE = "subscribe"
    end
  end
end
