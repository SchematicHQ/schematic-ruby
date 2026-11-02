# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ComponentState
      extend Schematic::Internal::Types::Enum

      DRAFT = "draft"
      LIVE = "live"
    end
  end
end
