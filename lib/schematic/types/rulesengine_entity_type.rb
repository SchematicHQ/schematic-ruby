# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module RulesengineEntityType
      extend Schematic::Internal::Types::Enum

      COMPANY = "company"
      USER = "user"
    end
  end
end
