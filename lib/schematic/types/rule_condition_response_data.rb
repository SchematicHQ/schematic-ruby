# frozen_string_literal: true

module Schematic
  module Types
    class RuleConditionResponseData < Internal::Types::Model
      field :comparison_trait_id, -> { String }, optional: true, nullable: false
      field :condition_group_id, -> { String }, optional: true, nullable: false
      field :condition_type, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metric_period, -> { String }, optional: true, nullable: false
      field :metric_period_month_reset, -> { String }, optional: true, nullable: false
      field :metric_value, -> { Integer }, optional: true, nullable: false
      field :operator, -> { String }, optional: false, nullable: false
      field :resource_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: false, nullable: false
      field :trait_entity_type, -> { Schematic::Types::EntityType }, optional: true, nullable: false
      field :trait_id, -> { String }, optional: true, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
