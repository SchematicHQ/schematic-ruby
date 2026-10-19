# frozen_string_literal: true

module Schematic
  module Types
    module PaymentGating
      extend Schematic::Internal::Types::Enum

      KEEP_SERVING = "keep_serving"
      REVOKE_AFTER = "revoke_after"
    end
  end
end
