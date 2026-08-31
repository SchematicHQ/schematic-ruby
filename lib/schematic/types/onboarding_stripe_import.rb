# frozen_string_literal: true

module Schematic
  module Types
    module OnboardingStripeImport
      extend Schematic::Internal::Types::Enum

      COMPLETE = "complete"
      NOT_STARTED = "not_started"
      RUNNING = "running"
    end
  end
end
