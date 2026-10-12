# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutProblemResponseData < Internal::Types::Model
      field :blocking, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :bundle_id, -> { String }, optional: true, nullable: false

      field :code, -> { Schematic::Types::CheckoutProblemCode }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :detail, -> { String }, optional: true, nullable: false

      field :feature_id, -> { String }, optional: true, nullable: false

      field :field_id, -> { String }, optional: true, nullable: false

      field :message, -> { String }, optional: false, nullable: false

      field :payment_method_id, -> { String }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :price_id, -> { String }, optional: true, nullable: false

      field :source, -> { Schematic::Types::CheckoutProblemSource }, optional: false, nullable: false
    end
  end
end
