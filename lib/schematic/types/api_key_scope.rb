# frozen_string_literal: true

module Schematic
  module Types
    module ApiKeyScope
      extend Schematic::Internal::Types::Enum

      ADMIN = "admin"
      CAPTURE = "capture"
      READ = "read"
      WRITE = "write"
    end
  end
end
