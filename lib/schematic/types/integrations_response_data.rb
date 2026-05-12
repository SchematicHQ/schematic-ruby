# frozen_string_literal: true

module Schematic
  module Types
    class IntegrationsResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :state, -> { Schematic::Types::IntegrationState }, optional: false, nullable: false
      field :type, -> { Schematic::Types::IntegrationType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
