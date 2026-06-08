# frozen_string_literal: true

module Schematic
  module Types
    class IntegrationInstallConfig < Internal::Types::Model
      field :company_matching_criteria, -> { Schematic::Types::CompanyMatchingCriteria }, optional: true, nullable: false
      field :company_matching_field, -> { String }, optional: true, nullable: false
      field :config, -> { Schematic::Types::IntegrationConfig }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :integration_id, -> { String }, optional: false, nullable: false
      field :is_app_install, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :is_connect_install, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :live_mode, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
