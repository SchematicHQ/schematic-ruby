# frozen_string_literal: true

module Schematic
  module Types
    class PreviewSubscriptionFinanceResponseData < Internal::Types::Model
      field :amount_off, -> { Integer }, optional: false, nullable: false
      field :due_now, -> { Integer }, optional: false, nullable: false
      field :new_charges, -> { Integer }, optional: false, nullable: false
      field :percent_off, -> { Integer }, optional: false, nullable: false
      field :period_start, -> { String }, optional: false, nullable: false
      field :promo_code_applied, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :proration, -> { Integer }, optional: false, nullable: false
      field :tax_amount, -> { Integer }, optional: true, nullable: false
      field :tax_display_name, -> { String }, optional: true, nullable: false
      field :tax_require_billing_details, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :total_per_billing_period, -> { Integer }, optional: false, nullable: false
      field :trial_end, -> { String }, optional: true, nullable: false
      field :upcoming_invoice_line_items, -> { Internal::Types::Array[Schematic::Types::PreviewSubscriptionUpcomingInvoiceLineItems] }, optional: false, nullable: false
    end
  end
end
