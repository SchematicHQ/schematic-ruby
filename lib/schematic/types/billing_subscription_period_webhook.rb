# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingSubscriptionPeriodWebhook < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :contract_id, -> { String }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::BillingSubscriptionPeriodLineWebhook] }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :subscription_id, -> { String }, optional: false, nullable: false
    end
  end
end
