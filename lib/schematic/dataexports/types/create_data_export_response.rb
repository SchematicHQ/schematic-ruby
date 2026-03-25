# frozen_string_literal: true

module Schematic
  module Dataexports
    module Types
      class CreateDataExportResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DataExportResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
