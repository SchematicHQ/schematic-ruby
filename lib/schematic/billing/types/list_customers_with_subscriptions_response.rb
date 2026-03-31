# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListCustomersWithSubscriptionsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingCustomerWithSubscriptionsResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::ListCustomersWithSubscriptionsParams }, optional: false, nullable: false
      end
    end
  end
end
