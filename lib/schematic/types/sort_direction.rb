# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module SortDirection
      extend Schematic::Internal::Types::Enum

      ASC = "asc"
      DESC = "desc"
    end
  end
end
