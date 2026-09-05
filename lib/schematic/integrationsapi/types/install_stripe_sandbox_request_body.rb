# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class InstallStripeSandboxRequestBody < Internal::Types::Model
        field :country, -> { String }, optional: true, nullable: false

        field :email, -> { String }, optional: false, nullable: false

        field :name, -> { String }, optional: true, nullable: false

        field :seed_sample_data, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
