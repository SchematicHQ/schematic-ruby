# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module DataExportOutputFileType
      extend Schematic::Internal::Types::Enum

      CSV = "csv"
      CSV_GZ = "csv.gz"
    end
  end
end
