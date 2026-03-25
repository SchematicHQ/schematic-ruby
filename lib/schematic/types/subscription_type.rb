# frozen_string_literal: true

module Schematic
  module Types
    module SubscriptionType
      extend Schematic::Internal::Types::Enum

      FREE = "free"
      ONE_TIME = "one_time"
      PAID = "paid"
      TRIAL = "trial"
    end
  end
end
