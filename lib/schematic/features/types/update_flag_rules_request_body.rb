# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class UpdateFlagRulesRequestBody < Internal::Types::Model
        field :flag_id, -> { String }, optional: false, nullable: false
        field :rules, -> { Internal::Types::Array[Schematic::Types::CreateOrUpdateRuleRequestBody] }, optional: false, nullable: false
      end
    end
  end
end
