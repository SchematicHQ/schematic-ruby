# frozen_string_literal: true

module Schematic
  module Types
    class CompanyOverrideResponseData < Internal::Types::Model
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :expiration_date, -> { String }, optional: true, nullable: false
      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false
      field :notes, -> { Internal::Types::Array[Schematic::Types::CompanyOverrideNoteResponseData] }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: true, nullable: false
      field :rule_id_usage_exceeded, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :value_numeric, -> { Integer }, optional: true, nullable: false
      field :value_trait, -> { Schematic::Types::EntityTraitDefinitionResponseData }, optional: true, nullable: false
      field :value_trait_id, -> { String }, optional: true, nullable: false
      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
    end
  end
end
