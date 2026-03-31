# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class ListFlagsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FlagDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Features::Types::ListFlagsParams }, optional: false, nullable: false
      end
    end
  end
end
