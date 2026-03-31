# frozen_string_literal: true

module Schematic
  module Types
    class BillingSubscriptionDiscount < Internal::Types::Model
      field :coupon_external_id, -> { String }, optional: false, nullable: false
      field :customer_facing_code, -> { String }, optional: true, nullable: false
      field :ended_at, -> { String }, optional: true, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :is_active, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :promo_code_external_id, -> { String }, optional: true, nullable: false
      field :started_at, -> { String }, optional: false, nullable: false
    end
  end
end
