# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCompany < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :base_plan_id, -> { String }, optional: true, nullable: false
      field :billing_product_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :credit_balances, -> { Internal::Types::Hash[String, Integer] }, optional: false, nullable: false
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::RulesengineFeatureEntitlement] }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :metrics, -> { Internal::Types::Array[Schematic::Types::RulesengineCompanyMetric] }, optional: false, nullable: false
      field :plan_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :plan_version_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :rules, -> { Internal::Types::Array[Schematic::Types::RulesengineRule] }, optional: false, nullable: false
      field :subscription, -> { Schematic::Types::RulesengineSubscription }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Array[Schematic::Types::RulesengineTrait] }, optional: false, nullable: false
    end
  end
end
