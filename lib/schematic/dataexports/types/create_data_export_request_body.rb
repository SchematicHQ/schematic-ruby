# frozen_string_literal: true

module Schematic
  module Dataexports
    module Types
      class CreateDataExportRequestBody < Internal::Types::Model
        field :export_type, -> { String }, optional: false, nullable: false
        field :metadata, -> { String }, optional: false, nullable: false
        field :output_file_type, -> { String }, optional: false, nullable: false
      end
    end
  end
end
