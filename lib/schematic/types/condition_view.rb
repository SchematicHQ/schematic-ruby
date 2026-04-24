# frozen_string_literal: true

module Schematic
  module Types
    class ConditionView < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :billing_products, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
      field :companies, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
      field :comparison_trait, -> { Schematic::Types::EntityTraitDefinitionResponseData }, optional: true, nullable: false
      field :comparison_trait_id, -> { String }, optional: true, nullable: false
      field :condition_group_id, -> { String }, optional: true, nullable: false
      field :condition_type, -> { Schematic::Types::ConditionType }, optional: false, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit_id, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false
      field :metric_value, -> { Integer }, optional: true, nullable: false
      field :operator, -> { Schematic::Types::ComparableOperator }, optional: false, nullable: false
      field :plan_versions, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
      field :plans, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
      field :resource_unspecified_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: false, nullable: false
      field :trait, -> { Schematic::Types::EntityTraitDefinitionResponseData }, optional: true, nullable: false
      field :trait_entity_type, -> { Schematic::Types::EntityType }, optional: true, nullable: false
      field :trait_id, -> { String }, optional: true, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
      field :trait_value_bool, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :trait_value_date, -> { String }, optional: true, nullable: false
      field :trait_value_int, -> { Integer }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :users, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
    end
  end
end
