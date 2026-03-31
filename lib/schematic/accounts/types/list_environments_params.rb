# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      # Input parameters
      class ListEnvironmentsParams < Internal::Types::Model
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
