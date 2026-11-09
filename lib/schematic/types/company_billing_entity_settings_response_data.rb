# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyBillingEntitySettingsResponseData < Internal::Types::Model
      field :billing_date, -> { String }, optional: true, nullable: false

      field :children_may_change_plan, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false
    end
  end
end
