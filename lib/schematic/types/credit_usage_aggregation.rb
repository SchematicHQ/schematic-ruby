# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditUsageAggregation < Internal::Types::Model
      field :usage_this_billing_period, -> { Float }, optional: true, nullable: false

      field :usage_this_calendar_month, -> { Float }, optional: true, nullable: false

      field :usage_this_week, -> { Float }, optional: true, nullable: false

      field :usage_today, -> { Float }, optional: true, nullable: false
    end
  end
end
