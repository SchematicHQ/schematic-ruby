# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Accounts
    module Types
      # Input parameters
      class CountApiKeysParams < Internal::Types::Model
        field :environment_id, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :require_environment, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
