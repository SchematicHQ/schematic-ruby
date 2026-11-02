# frozen_string_literal: true

require_relative "../../schematic"

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
