# frozen_string_literal: true

module Schematic
  module Types
    class RuleView < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :condition_groups, -> { Internal::Types::Array[Schematic::Types::ConditionGroupView] }, optional: false, nullable: false
      field :conditions, -> { Internal::Types::Array[Schematic::Types::ConditionView] }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :priority, -> { Integer }, optional: false, nullable: false
      field :rule_type, -> { Schematic::Types::RuleType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
