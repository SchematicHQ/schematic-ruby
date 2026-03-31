# frozen_string_literal: true

module Schematic
  module Types
    class BillingCustomerSubscription < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :expired_at, -> { String }, optional: true, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :metered_usage, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :per_unit_price, -> { Integer }, optional: false, nullable: false
      field :total_price, -> { Integer }, optional: false, nullable: false
    end
  end
end
