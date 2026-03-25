# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class CountApiKeysResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Accounts::Types::CountApiKeysParams }, optional: false, nullable: false
      end
    end
  end
end
