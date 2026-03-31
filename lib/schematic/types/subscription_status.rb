# frozen_string_literal: true

module Schematic
  module Types
    module SubscriptionStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      CANCELED = "canceled"
      EXPIRED = "expired"
      INCOMPLETE = "incomplete"
      INCOMPLETE_EXPIRED = "incomplete_expired"
      PAST_DUE = "past_due"
      PAUSED = "paused"
      TRIALING = "trialing"
      UNPAID = "unpaid"
    end
  end
end
