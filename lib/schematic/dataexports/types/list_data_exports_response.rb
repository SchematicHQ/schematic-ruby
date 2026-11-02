# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Dataexports
    module Types
      class ListDataExportsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::DataExportResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Dataexports::Types::ListDataExportsParams }, optional: false, nullable: false
      end
    end
  end
end
