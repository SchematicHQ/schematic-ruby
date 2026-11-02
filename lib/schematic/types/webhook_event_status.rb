# frozen_string_literal: true

require_relative "../../schematic"

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
