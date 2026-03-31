# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UpsertBillingCouponResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::BillingCouponResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
