# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ListBillingProductsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingProductDetailResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListBillingProductsParams }, optional: false, nullable: false
      end
    end
  end
end
