# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class PauseSubscriptionRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false

        field :months, -> { Integer }, optional: false, nullable: false

        field :subscription_external_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
