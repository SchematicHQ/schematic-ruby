# frozen_string_literal: true

module Schematic
  module Types
    class CompanyPlanWithBillingSubView < Internal::Types::Model
      field :added_on, -> { String }, optional: true, nullable: false
      field :billing_product_external_id, -> { String }, optional: true, nullable: false
      field :billing_product_id, -> { String }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :image_url, -> { String }, optional: true, nullable: false
      field :included_credit_grants, -> { Internal::Types::Array[Schematic::Types::PlanCreditGrantView] }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plan_period, -> { String }, optional: true, nullable: false
      field :plan_price, -> { Integer }, optional: true, nullable: false
      field :plan_version_id, -> { String }, optional: true, nullable: false
    end
  end
end
