# frozen_string_literal: true

require_relative "../../schematic"

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
