# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanVersionMigrationPreviewResponseData < Internal::Types::Model
      field :companies, -> { Internal::Types::Array[Schematic::Types::PlanVersionMigrationPreviewCompanyResponseData] }, optional: false, nullable: false

      field :has_billing_changes, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
