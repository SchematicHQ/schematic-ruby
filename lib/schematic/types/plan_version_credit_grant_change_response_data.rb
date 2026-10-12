# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionCreditGrantChangeResponseData < Internal::Types::Model
      field :change_type, -> { Schematic::Types::PlanVersionDiffChangeType }, optional: false, nullable: false

      field :changed_fields, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :credit_id, -> { String }, optional: false, nullable: false

      field :new, -> { Schematic::Types::BillingPlanCreditGrantResponseData }, optional: true, nullable: false

      field :old, -> { Schematic::Types::BillingPlanCreditGrantResponseData }, optional: true, nullable: false
    end
  end
end
