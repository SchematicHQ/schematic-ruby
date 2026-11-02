# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanVersionMigrationPreviewNoteResponseData < Internal::Types::Model
      field :blocking, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :code, -> { Schematic::Types::MigrationErrorCode }, optional: true, nullable: false

      field :message, -> { String }, optional: false, nullable: false
    end
  end
end
