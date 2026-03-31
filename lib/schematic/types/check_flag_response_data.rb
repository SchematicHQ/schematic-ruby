# frozen_string_literal: true

module Schematic
  module Types
    class CheckFlagResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false
      field :entitlement, -> { Schematic::Types::FeatureEntitlement }, optional: true, nullable: false
      field :error, -> { String }, optional: true, nullable: false
      field :feature_allocation, -> { Integer }, optional: true, nullable: false
      field :feature_usage, -> { Integer }, optional: true, nullable: false
      field :feature_usage_event, -> { String }, optional: true, nullable: false
      field :feature_usage_period, -> { String }, optional: true, nullable: false
      field :feature_usage_reset_at, -> { String }, optional: true, nullable: false
      field :flag, -> { String }, optional: false, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: true, nullable: false
      field :rule_type, -> { String }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
