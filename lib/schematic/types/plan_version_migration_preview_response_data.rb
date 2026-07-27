# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionMigrationPreviewResponseData < Internal::Types::Model
      field :companies, -> { Internal::Types::Array[Schematic::Types::PlanVersionMigrationPreviewCompanyResponseData] }, optional: false, nullable: false
    end
  end
end
