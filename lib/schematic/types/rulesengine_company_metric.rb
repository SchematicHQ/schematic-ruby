# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCompanyMetric < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: false, nullable: false
      field :month_reset, -> { Schematic::Types::RulesengineMetricPeriodMonthReset }, optional: false, nullable: false
      field :period, -> { Schematic::Types::RulesengineMetricPeriod }, optional: false, nullable: false
      field :valid_until, -> { String }, optional: true, nullable: false
      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
