# frozen_string_literal: true

module Schematic
  module Types
    module BillingTiersMode
      extend Schematic::Internal::Types::Enum

      GRADUATED = "graduated"
      VOLUME = "volume"
    end
  end
end
