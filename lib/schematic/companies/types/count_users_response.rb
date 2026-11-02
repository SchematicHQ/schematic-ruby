# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class CountUsersResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::CountUsersParams }, optional: false, nullable: false
      end
    end
  end
end
