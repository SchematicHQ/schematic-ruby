# frozen_string_literal: true

module Schematic
  module Types
    class ChangeSubscriptionRequestBody < Internal::Types::Model
      field :add_on_ids, -> { Internal::Types::Array[Schematic::Types::UpdateAddOnRequestBody] }, optional: false, nullable: false
      field :coupon_external_id, -> { String }, optional: true, nullable: false
      field :credit_bundles, -> { Internal::Types::Array[Schematic::Types::UpdateCreditBundleRequestBody] }, optional: false, nullable: false
      field :new_plan_id, -> { String }, optional: false, nullable: false
      field :new_price_id, -> { String }, optional: false, nullable: false
      field :pay_in_advance, -> { Internal::Types::Array[Schematic::Types::UpdatePayInAdvanceRequestBody] }, optional: false, nullable: false
      field :payment_method_id, -> { String }, optional: true, nullable: false
      field :promo_code, -> { String }, optional: true, nullable: false
      field :skip_trial, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
