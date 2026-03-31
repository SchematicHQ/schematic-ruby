# frozen_string_literal: true

module Schematic
  module Types
    class CouponRequestBody < Internal::Types::Model
      field :amount_off, -> { Integer }, optional: false, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :duration, -> { String }, optional: false, nullable: false
      field :duration_in_months, -> { Integer }, optional: false, nullable: false
      field :max_redemptions, -> { Integer }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :percent_off, -> { Integer }, optional: false, nullable: false
      field :times_redeemed, -> { Integer }, optional: false, nullable: false
    end
  end
end
