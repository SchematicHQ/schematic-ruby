# frozen_string_literal: true

module Schematic
  module Types
    class BillingCouponResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :amount_off, -> { Integer }, optional: true, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :duration, -> { String }, optional: true, nullable: false
      field :duration_in_months, -> { Integer }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :is_active, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :max_redemptions, -> { Integer }, optional: true, nullable: false
      field :metadata, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :percent_off, -> { Integer }, optional: true, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :times_redeemed, -> { Integer }, optional: false, nullable: false
      field :valid_from, -> { String }, optional: true, nullable: false
      field :valid_until, -> { String }, optional: true, nullable: false
    end
  end
end
