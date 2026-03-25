# frozen_string_literal: true

module Schematic
  module Types
    class PlanChangeResponseData < Internal::Types::Model
      field :action, -> { Schematic::Types::PlanChangeAction }, optional: false, nullable: false
      field :actor_type, -> { Schematic::Types::ActorType }, optional: false, nullable: false
      field :add_ons_added, -> { Internal::Types::Array[Schematic::Types::PlanSnapshotView] }, optional: false, nullable: false
      field :add_ons_removed, -> { Internal::Types::Array[Schematic::Types::PlanSnapshotView] }, optional: false, nullable: false
      field :api_key, -> { Schematic::Types::ApiKeyResponseData }, optional: true, nullable: false
      field :audit_log, -> { Schematic::Types::AuditLogListResponseData }, optional: true, nullable: false
      field :base_plan, -> { Schematic::Types::PlanSnapshotView }, optional: true, nullable: false
      field :base_plan_action, -> { Schematic::Types::PlanChangeBasePlanAction }, optional: true, nullable: false
      field :base_plan_version, -> { Schematic::Types::PlanVersionSnapshotView }, optional: true, nullable: false
      field :company, -> { Schematic::Types::CompanyResponseData }, optional: true, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :previous_base_plan, -> { Schematic::Types::PlanSnapshotView }, optional: true, nullable: false
      field :previous_base_plan_version, -> { Schematic::Types::PlanVersionSnapshotView }, optional: true, nullable: false
      field :request_id, -> { String }, optional: true, nullable: false
      field :subscription_change_action, -> { Schematic::Types::PlanChangeSubscriptionAction }, optional: true, nullable: false
      field :traits_updated, -> { Internal::Types::Array[Schematic::Types::SubscriptionTraitUpdate] }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :user_name, -> { String }, optional: true, nullable: false
    end
  end
end
