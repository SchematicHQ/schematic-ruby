# frozen_string_literal: true

module Schematic
  module Types
    class InstallIntegrationRequestBody < Internal::Types::Model
      field :company_matching_criteria, -> { Schematic::Types::CompanyMatchingCriteria }, optional: true, nullable: false
      field :company_matching_field, -> { String }, optional: true, nullable: false
      field :config, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :is_sandbox, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :live_mode, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :type, -> { Schematic::Types::IntegrationType }, optional: false, nullable: false
    end
  end
end
