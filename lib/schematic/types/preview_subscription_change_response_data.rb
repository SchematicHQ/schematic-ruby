# frozen_string_literal: true

module Schematic
  module Types
    class PreviewSubscriptionChangeResponseData < Internal::Types::Model
      field :amount_off, -> { Integer }, optional: false, nullable: false
      field :due_now, -> { Integer }, optional: false, nullable: false
      field :finance, -> { Schematic::Types::PreviewSubscriptionFinanceResponseData }, optional: true, nullable: false
      field :is_scheduled_downgrade, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :new_charges, -> { Integer }, optional: false, nullable: false
      field :payment_method_required, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :percent_off, -> { Integer }, optional: false, nullable: false
      field :period_start, -> { String }, optional: false, nullable: false
      field :promo_code_applied, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :proration, -> { Integer }, optional: false, nullable: false
      field :scheduled_change_time, -> { String }, optional: true, nullable: false
      field :trial_end, -> { String }, optional: true, nullable: false
      field :usage_violations, -> { Internal::Types::Array[Schematic::Types::FeatureUsageResponseData] }, optional: false, nullable: false
    end
  end
end
