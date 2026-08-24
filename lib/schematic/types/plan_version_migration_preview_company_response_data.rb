# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionMigrationPreviewCompanyResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :has_billing_changes, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :has_custom_pricing, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :note, -> { String }, optional: true, nullable: false

      field :plan_version_id_from, -> { String }, optional: true, nullable: false

      field :will_update_subscription, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :would_fail, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
