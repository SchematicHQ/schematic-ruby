# frozen_string_literal: true

module Schematic
  module Types
    module WebhookEventStatus
      extend Schematic::Internal::Types::Enum

      FAILURE = "failure"
      PENDING = "pending"
      SUCCESS = "success"
    end
  end
end
