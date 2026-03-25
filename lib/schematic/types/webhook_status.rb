# frozen_string_literal: true

module Schematic
  module Types
    module WebhookStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      INACTIVE = "inactive"
    end
  end
end
