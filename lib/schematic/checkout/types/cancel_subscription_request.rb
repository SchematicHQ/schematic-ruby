# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class CancelSubscriptionRequest < Internal::Types::Model
        field :cancel_immediately, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :company_id, -> { String }, optional: false, nullable: false
        field :prorate, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
