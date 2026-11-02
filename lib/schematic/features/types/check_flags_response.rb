# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Features
    module Types
      class CheckFlagsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CheckFlagsResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
