# frozen_string_literal: true

module Schematic
  module Types
    class CatalogCreditGrantResponseData < Internal::Types::Model
      field :company_credit_amount, -> { Integer }, optional: false, nullable: false

      field :credit_amount, -> { Integer }, optional: false, nullable: false

      field :credit_icon, -> { String }, optional: true, nullable: false

      field :credit_id, -> { String }, optional: false, nullable: false

      field :credit_name, -> { String }, optional: false, nullable: false

      field :credit_plural_name, -> { String }, optional: true, nullable: false

      field :credit_singular_name, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :license_id, -> { String }, optional: true, nullable: false

      field :reset_cadence, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: true, nullable: false

      field :scaling, -> { Schematic::Types::PlanCreditGrantScaling }, optional: false, nullable: false
    end
  end
end
