# frozen_string_literal: true

module Schematic
  module Types
    class PaymentMethodBillingDetailsRequestBody < Internal::Types::Model
      field :address, -> { Schematic::Types::CustomerBillingAddress }, optional: true, nullable: false

      field :email, -> { String }, optional: true, nullable: false

      field :phone, -> { String }, optional: true, nullable: false
    end
  end
end
