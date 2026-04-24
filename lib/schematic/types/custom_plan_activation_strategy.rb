# frozen_string_literal: true

module Schematic
  module Types
    module CustomPlanActivationStrategy
      extend Schematic::Internal::Types::Enum

      ON_PAYMENT = "on_payment"
      ON_PUBLISH = "on_publish"
    end
  end
end
