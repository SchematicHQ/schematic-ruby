# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Checkout
    module Types
      class GetCheckoutDataResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CheckoutDataResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
