# frozen_string_literal: true

module Schematic
  module Types
    class RuleConditionGroupResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
