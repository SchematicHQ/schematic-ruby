# frozen_string_literal: true

module Schematic
  module Types
    module RenewalPolicy
      extend Schematic::Internal::Types::Enum

      AUTO_RENEW = "auto_renew"
      EXPIRE_TO_DEFAULT = "expire_to_default"
      HOLD_WITH_GRACE = "hold_with_grace"
    end
  end
end
