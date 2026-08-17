# frozen_string_literal: true

module Schematic
  module Types
    class ManagePlanRequest < Internal::Types::Model
      field :activate_on_payment, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :add_on_selections, -> { Internal::Types::Array[Schematic::Types::PlanSelection] }, optional: false, nullable: false
      field :base_plan_id, -> { String }, optional: true, nullable: false
      field :base_plan_price_id, -> { String }, optional: true, nullable: false
      field :base_plan_version_id, -> { String }, optional: true, nullable: false
      field :billing_cycle_anchor, -> { String }, optional: true, nullable: false
      field :billing_email, -> { String }, optional: true, nullable: false
      field :billing_entity_id, -> { String }, optional: true, nullable: false
      field :cancel_immediately, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :collection_method, -> { Schematic::Types::BillingCollectionMethod }, optional: true, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :coupon_external_id, -> { String }, optional: true, nullable: false
      field :credit_bundles, -> { Internal::Types::Array[Schematic::Types::UpdateCreditBundleRequestBody] }, optional: false, nullable: false
      field :custom_field_values, -> { Internal::Types::Array[Schematic::Types::CheckoutFieldValue] }, optional: false, nullable: false
      field :days_until_due, -> { Integer }, optional: true, nullable: false
      field :pay_in_advance_entitlements, -> { Internal::Types::Array[Schematic::Types::UpdatePayInAdvanceRequestBody] }, optional: false, nullable: false
      field :payment_method_external_id, -> { String }, optional: true, nullable: false
      field :promo_code, -> { String }, optional: true, nullable: false
      field :prorate, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :prorate_first_period, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :send_invoice, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :trial_end, -> { String }, optional: true, nullable: false
    end
  end
end
