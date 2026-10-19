# frozen_string_literal: true

module Schematic
  module Types
    class PublishPreviewResponseData < Internal::Types::Model
      field :billing_email, -> { String }, optional: true, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :current_period_end, -> { String }, optional: true, nullable: false

      field :current_period_start, -> { String }, optional: true, nullable: false

      field :default_collection_method, -> { Schematic::Types::BillingCollectionMethod }, optional: false, nullable: false

      field :default_days_until_due, -> { Integer }, optional: false, nullable: false

      field :default_send_invoice, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :effective_at, -> { String }, optional: true, nullable: false

      field :has_billing_changes, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :immediate_invoice_amount, -> { Integer }, optional: true, nullable: false

      field :lands_on, -> { Schematic::Types::AmendmentProrationLandsOn }, optional: false, nullable: false

      field :new_recurring_amount, -> { Integer }, optional: true, nullable: false

      field :next_invoice_amount, -> { Integer }, optional: true, nullable: false

      field :next_invoice_at, -> { String }, optional: true, nullable: false

      field :note, -> { String }, optional: true, nullable: false

      field :pay_in_advance, -> { Internal::Types::Array[Schematic::Types::PublishPreviewPayInAdvanceResponseData] }, optional: false, nullable: false

      field :payment_method, -> { Schematic::Types::PublishPreviewPaymentMethodResponseData }, optional: false, nullable: false

      field :proration_charge, -> { Integer }, optional: false, nullable: false

      field :proration_credit, -> { Integer }, optional: false, nullable: false

      field :proration_lines, -> { Internal::Types::Array[Schematic::Types::PublishPreviewProrationLineResponseData] }, optional: false, nullable: false

      field :proration_total, -> { Integer }, optional: false, nullable: false

      field :will_update_subscription, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :would_fail, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
