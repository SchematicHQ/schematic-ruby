# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ChargeNativeInvoiceResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::BillingInvoiceDetailResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
