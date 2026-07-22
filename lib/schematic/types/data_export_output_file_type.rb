# frozen_string_literal: true

module Schematic
  module Types
    module DataExportOutputFileType
      extend Schematic::Internal::Types::Enum

      CSV = "csv"
      CSV_GZ = "csv.gz"
    end
  end
end
