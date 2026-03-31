# frozen_string_literal: true

module Schematic
  module Types
    module DataExportStatus
      extend Schematic::Internal::Types::Enum

      FAILURE = "failure"
      PENDING = "pending"
      SUCCESS = "success"
    end
  end
end
