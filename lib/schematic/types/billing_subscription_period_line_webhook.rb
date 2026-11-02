# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingSubscriptionPeriodLineWebhook < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :quantity, -> { Integer }, optional: true, nullable: false

      field :source_id, -> { String }, optional: false, nullable: false

      field :unit_amount, -> { Integer }, optional: true, nullable: false
    end
  end
end
