# frozen_string_literal: true

module Schematic
  module Plangroups
    module Types
      class UpdatePlanGroupRequestBody < Internal::Types::Model
        field :plan_group_id, -> { String }, optional: false, nullable: false
        field :add_on_compatibilities, -> { Internal::Types::Array[Schematic::Types::CompatiblePlans] }, optional: true, nullable: false
        field :add_on_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
        field :checkout_collect_address, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :checkout_collect_email, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :checkout_collect_phone, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :custom_plan_config, -> { Schematic::Types::CustomPlanConfig }, optional: true, nullable: false
        field :custom_plan_id, -> { String }, optional: true, nullable: false
        field :enable_tax_collection, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :fallback_plan_id, -> { String }, optional: true, nullable: false
        field :initial_plan_id, -> { String }, optional: true, nullable: false
        field :initial_plan_price_id, -> { String }, optional: true, nullable: false
        field :ordered_add_ons, -> { Internal::Types::Array[Schematic::Types::OrderedPlansInGroup] }, optional: false, nullable: false
        field :ordered_bundle_list, -> { Internal::Types::Array[Schematic::Types::PlanGroupBundleOrder] }, optional: false, nullable: false
        field :ordered_plans, -> { Internal::Types::Array[Schematic::Types::OrderedPlansInGroup] }, optional: false, nullable: false
        field :prevent_downgrades_when_over_limit, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :prevent_self_service_downgrade, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :prevent_self_service_downgrade_button_text, -> { String }, optional: true, nullable: false
        field :prevent_self_service_downgrade_url, -> { String }, optional: true, nullable: false
        field :proration_behavior, -> { Schematic::Types::ProrationBehavior }, optional: false, nullable: false
        field :scheduled_downgrade_behavior, -> { Schematic::Types::ScheduledDowngradeConfigBehavior }, optional: true, nullable: false
        field :scheduled_downgrade_prevent_when_over_limit, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :show_as_monthly_prices, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :show_credits, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :show_feature_description, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :show_hard_limit, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :show_period_toggle, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :show_zero_price_as_free, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :sync_customer_billing_details, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :trial_days, -> { Integer }, optional: true, nullable: false
        field :trial_expiry_plan_id, -> { String }, optional: true, nullable: false
        field :trial_expiry_plan_price_id, -> { String }, optional: true, nullable: false
        field :trial_payment_method_required, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
