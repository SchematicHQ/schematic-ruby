# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingMovedToDefaultPlanResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false

      field :voided_invoices, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
