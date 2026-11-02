# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingTiersMode
      extend Schematic::Internal::Types::Enum

      GRADUATED = "graduated"
      VOLUME = "volume"
    end
  end
end
