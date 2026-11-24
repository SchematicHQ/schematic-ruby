# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      class GetInferenceCostResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::InferenceCostResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Events::Types::GetInferenceCostParams }, optional: false, nullable: false
      end
    end
  end
end
