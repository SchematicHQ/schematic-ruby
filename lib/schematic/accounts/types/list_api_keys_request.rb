# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListApiKeysRequest < Internal::Types::Model
        field :environment_id, -> { String }, optional: true, nullable: false
        field :require_environment, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
