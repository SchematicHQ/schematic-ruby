# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListMetersResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingMeterResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::ListMetersParams }, optional: false, nullable: false
      end
    end
  end
end
