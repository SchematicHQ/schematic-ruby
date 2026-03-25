# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineRule < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :condition_groups, -> { Internal::Types::Array[Schematic::Types::RulesengineConditionGroup] }, optional: false, nullable: false
      field :conditions, -> { Internal::Types::Array[Schematic::Types::RulesengineCondition] }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :priority, -> { Integer }, optional: false, nullable: false
      field :rule_type, -> { Schematic::Types::RulesengineRuleRuleType }, optional: false, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
