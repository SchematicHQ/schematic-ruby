# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ListCouponsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingCouponResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListCouponsParams }, optional: false, nullable: false
      end
    end
  end
end
