# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineUser < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :rules, -> { Internal::Types::Array[Schematic::Types::RulesengineRule] }, optional: false, nullable: false
      field :traits, -> { Internal::Types::Array[Schematic::Types::RulesengineTrait] }, optional: false, nullable: false
    end
  end
end
