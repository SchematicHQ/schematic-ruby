# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListBillingProductPricesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingPriceView] }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::ListBillingProductPricesParams }, optional: false, nullable: false
      end
    end
  end
end
