# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Accounts
    module Types
      class ListEnvironmentsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EnvironmentResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Accounts::Types::ListEnvironmentsParams }, optional: false, nullable: false
      end
    end
  end
end
