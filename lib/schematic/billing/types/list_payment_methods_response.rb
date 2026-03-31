# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListPaymentMethodsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PaymentMethodResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::ListPaymentMethodsParams }, optional: false, nullable: false
      end
    end
  end
end
