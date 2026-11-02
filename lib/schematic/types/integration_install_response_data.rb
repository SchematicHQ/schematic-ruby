# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class IntegrationInstallResponseData < Internal::Types::Model
      field :capabilities, -> { Schematic::Types::IntegrationCapabilities }, optional: false, nullable: false

      field :config, -> { Schematic::Types::IntegrationInstallConfig }, optional: false, nullable: false

      field :integration, -> { Schematic::Types::IntegrationResponseData }, optional: false, nullable: false
    end
  end
end
