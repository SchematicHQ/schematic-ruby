# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class CreateEnvironmentRequestBody < Internal::Types::Model
        field :environment_type, -> { Schematic::Types::EnvironmentType }, optional: false, nullable: false
        field :name, -> { String }, optional: false, nullable: false
      end
    end
  end
end
