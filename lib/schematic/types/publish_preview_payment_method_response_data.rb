# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PublishPreviewPaymentMethodResponseData < Internal::Types::Model
      field :card_brand, -> { String }, optional: true, nullable: false

      field :card_last_4, -> { String }, optional: true, nullable: false, api_name: "card_last4"

      field :has_default, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :payment_method_type, -> { String }, optional: true, nullable: false
    end
  end
end
