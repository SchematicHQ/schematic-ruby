# frozen_string_literal: true

module Schematic
  module Types
    class BillingSubscriptionDiscountView < Internal::Types::Model
      field :amount_off, -> { Integer }, optional: true, nullable: false
      field :coupon_id, -> { String }, optional: false, nullable: false
      field :coupon_name, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :customer_facing_code, -> { String }, optional: true, nullable: false
      field :discount_external_id, -> { String }, optional: false, nullable: false
      field :duration, -> { String }, optional: false, nullable: false
      field :duration_in_months, -> { Integer }, optional: true, nullable: false
      field :ended_at, -> { String }, optional: true, nullable: false
      field :is_active, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :percent_off, -> { Integer }, optional: true, nullable: false
      field :promo_code_external_id, -> { String }, optional: true, nullable: false
      field :started_at, -> { String }, optional: false, nullable: false
      field :subscription_external_id, -> { String }, optional: false, nullable: false
    end
  end
end
