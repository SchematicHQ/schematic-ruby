# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class LookupUserResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::UserDetailResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::LookupUserParams }, optional: false, nullable: false
      end
    end
  end
end
