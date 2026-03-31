# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListApiKeysResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::ApiKeyResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Accounts::Types::ListApiKeysParams }, optional: false, nullable: false
      end
    end
  end
end
