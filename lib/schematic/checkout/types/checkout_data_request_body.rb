# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class CheckoutDataRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :selected_plan_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
