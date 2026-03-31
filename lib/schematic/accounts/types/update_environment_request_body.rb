# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class UpdateEnvironmentRequestBody < Internal::Types::Model
        field :environment_id, -> { String }, optional: false, nullable: false
        field :environment_type, -> { Schematic::Types::EnvironmentType }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
      end
    end
  end
end
