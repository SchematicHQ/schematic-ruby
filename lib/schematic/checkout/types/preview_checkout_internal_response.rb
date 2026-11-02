# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Checkout
    module Types
      class PreviewCheckoutInternalResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PreviewSubscriptionChangeResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
