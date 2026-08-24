# frozen_string_literal: true

module Schematic
  module Dataexports
    module Types
      class CreateDataExportRequestBody < Internal::Types::Model
        field :export_type, -> { Schematic::Types::DataExportType }, optional: false, nullable: false

        field :metadata, -> { Schematic::Types::DataExportMetadata }, optional: true, nullable: false

        field :output_file_type, -> { Schematic::Types::DataExportOutputFileType }, optional: false, nullable: false
      end
    end
  end
end
