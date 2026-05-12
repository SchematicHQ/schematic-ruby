# frozen_string_literal: true

module Schematic
  module Types
    class ApiKeyIntegrationResponseData < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :state, -> { Schematic::Types::IntegrationState }, optional: false, nullable: false
      field :type, -> { Schematic::Types::IntegrationType }, optional: false, nullable: false
    end
  end
end
