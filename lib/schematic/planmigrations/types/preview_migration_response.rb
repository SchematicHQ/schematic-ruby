# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Planmigrations
    module Types
      class PreviewMigrationResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanVersionMigrationPreviewResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
