# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UpsertBillingPriceResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::BillingPriceResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
