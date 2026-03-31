# frozen_string_literal: true

module Schematic
  module Types
    class DataExportResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :export_type, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metadata, -> { String }, optional: false, nullable: false
      field :output_file_type, -> { String }, optional: false, nullable: false
      field :status, -> { Schematic::Types::DataExportStatus }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
