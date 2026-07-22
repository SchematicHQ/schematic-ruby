# frozen_string_literal: true

module Schematic
  module Dataexports
    module Types
      class ListDataExportsRequest < Internal::Types::Model
        field :export_type, -> { Schematic::Types::DataExportType }, optional: true, nullable: false
        field :status, -> { Schematic::Types::DataExportStatus }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
