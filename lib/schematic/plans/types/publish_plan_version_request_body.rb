# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class PublishPlanVersionRequestBody < Internal::Types::Model
        field :plan_version_id, -> { String }, optional: false, nullable: false
        field :activation_strategy, -> { Schematic::Types::CustomPlanActivationStrategy }, optional: true, nullable: false
        field :address, -> { Schematic::Types::CustomerBillingAddress }, optional: true, nullable: false
        field :coupon_external_id, -> { String }, optional: true, nullable: false
        field :custom_field_values, -> { Internal::Types::Array[Schematic::Types::CheckoutFieldValue] }, optional: true, nullable: false
        field :customer_email, -> { String }, optional: true, nullable: false
        field :days_until_due, -> { Integer }, optional: true, nullable: false
        field :excluded_company_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
        field :migration_strategy, -> { Schematic::Types::PlanVersionMigrationStrategy }, optional: false, nullable: false
        field :phone, -> { String }, optional: true, nullable: false
        field :proration_behavior, -> { Schematic::Types::MigrationProrationBehavior }, optional: true, nullable: false
        field :send_invoice, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :tax_id, -> { Schematic::Types::TaxIdInput }, optional: true, nullable: false
      end
    end
  end
end
