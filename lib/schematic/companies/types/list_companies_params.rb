# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class ListCompaniesParams < Internal::Types::Model
        field :credit_type_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :monetized_subscriptions, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :plan_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :sort_order_column, -> { String }, optional: true, nullable: false
        field :sort_order_direction, -> { Schematic::Types::SortDirection }, optional: true, nullable: false
        field :subscription_statuses, -> { Internal::Types::Array[Schematic::Types::SubscriptionStatus] }, optional: true, nullable: false
        field :subscription_types, -> { Internal::Types::Array[Schematic::Types::SubscriptionType] }, optional: true, nullable: false
        field :with_entitlement_for, -> { String }, optional: true, nullable: false
        field :with_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :without_feature_override_for, -> { String }, optional: true, nullable: false
        field :without_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :without_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
