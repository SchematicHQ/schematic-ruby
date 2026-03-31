# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListUsersResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::UserDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListUsersParams }, optional: false, nullable: false
      end
    end
  end
end
