# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Customplangrouprollouts
    module Types
      # Input parameters
      class ListGroupRolloutsParams < Internal::Types::Model
        field :plan_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
