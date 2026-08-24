# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class StartDataImportRequestBody < Internal::Types::Model
        field :company_matching_criteria, -> { Schematic::Types::CompanyMatchingCriteria }, optional: true, nullable: false

        field :company_matching_field, -> { String }, optional: true, nullable: false

        field :integration_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
