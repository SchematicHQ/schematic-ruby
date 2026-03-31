# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineFlag < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :default_value, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :rules, -> { Internal::Types::Array[Schematic::Types::RulesengineRule] }, optional: false, nullable: false
    end
  end
end
