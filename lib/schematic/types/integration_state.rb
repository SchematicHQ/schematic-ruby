# frozen_string_literal: true

module Schematic
  module Types
    module IntegrationState
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      CREATED = "created"
      PENDING = "pending"
    end
  end
end
