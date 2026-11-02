# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ListBillingPricesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingPriceView] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListBillingPricesParams }, optional: false, nullable: false
      end
    end
  end
end
