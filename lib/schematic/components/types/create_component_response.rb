# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Components
    module Types
      class CreateComponentResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ComponentResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
