# frozen_string_literal: true

module Schematic
  module Types
    class EntityTraitDefinitionUsage < Internal::Types::Model
      field :checkout_field_config_count, -> { Integer }, optional: false, nullable: false
      field :company_override_count, -> { Integer }, optional: false, nullable: false
      field :feature_count, -> { Integer }, optional: false, nullable: false
      field :plan_entitlement_count, -> { Integer }, optional: false, nullable: false
      field :plan_trait_count, -> { Integer }, optional: false, nullable: false
      field :rule_condition_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
