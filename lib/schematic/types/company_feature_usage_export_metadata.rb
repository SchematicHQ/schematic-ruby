# frozen_string_literal: true

module Schematic
  module Types
    class CompanyFeatureUsageExportMetadata < Internal::Types::Model
      field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :credit_type_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :entity_key_definition_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :entity_trait_definition_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :feature_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :has_scheduled_downgrade, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :monetized_subscriptions, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :plan_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :plan_version_id, -> { String }, optional: true, nullable: false

      field :plan_version_unpublished, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :q, -> { String }, optional: true, nullable: false

      field :sort_order_column, -> { String }, optional: true, nullable: false

      field :sort_order_direction, -> { Schematic::Types::CompanyFeatureUsageExportMetadataSortOrderDirection }, optional: true, nullable: false

      field :subscription_statuses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :subscription_types, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :visible_columns, -> { Internal::Types::Array[Schematic::Types::CompanyFeatureUsageExportMetadataVisibleColumnsItem] }, optional: true, nullable: false

      field :with_entitlement_for, -> { String }, optional: true, nullable: false

      field :with_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :without_feature_override_for, -> { String }, optional: true, nullable: false

      field :without_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :without_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
