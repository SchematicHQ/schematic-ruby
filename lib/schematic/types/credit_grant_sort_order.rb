# frozen_string_literal: true

module Schematic
  module Types
    module CreditGrantSortOrder
      extend Schematic::Internal::Types::Enum

      CREATED_AT = "created_at"
      EXPIRES_AT = "expires_at"
      QUANTITY = "quantity"
      QUANTITY_REMAINING = "quantity_remaining"
    end
  end
end
