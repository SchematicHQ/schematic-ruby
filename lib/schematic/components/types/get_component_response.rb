# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class GetComponentResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ComponentResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
