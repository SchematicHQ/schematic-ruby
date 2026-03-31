# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class DeleteEnvironmentResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
