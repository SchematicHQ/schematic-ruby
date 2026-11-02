# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Dataexports
    module Types
      class GetDataExportResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DataExportResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
