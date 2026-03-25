# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      # Input parameters
      class ListPaymentMethodsParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :customer_external_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
