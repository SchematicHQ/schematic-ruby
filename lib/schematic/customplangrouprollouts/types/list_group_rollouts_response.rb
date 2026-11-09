# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Customplangrouprollouts
    module Types
      class ListGroupRolloutsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::GroupRolloutResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Customplangrouprollouts::Types::ListGroupRolloutsParams }, optional: false, nullable: false
      end
    end
  end
end
