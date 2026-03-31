# frozen_string_literal: true

module Schematic
  module Scheduledcheckout
    module Types
      class UpdateScheduledCheckoutRequest < Internal::Types::Model
        field :scheduled_checkout_id, -> { String }, optional: false, nullable: false
        field :execute_after, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::ScheduledCheckoutStatus }, optional: true, nullable: false
      end
    end
  end
end
