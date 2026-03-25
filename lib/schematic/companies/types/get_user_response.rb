# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetUserResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::UserDetailResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
