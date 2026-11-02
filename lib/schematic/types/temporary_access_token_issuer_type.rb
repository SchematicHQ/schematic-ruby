# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module TemporaryAccessTokenIssuerType
      extend Schematic::Internal::Types::Enum

      API_KEY = "api_key"
      PRICING_ROADMAP = "pricing_roadmap"
    end
  end
end
