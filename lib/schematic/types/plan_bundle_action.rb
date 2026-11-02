# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanBundleAction
      extend Schematic::Internal::Types::Enum

      CREATE = "create"
      UPDATE = "update"
      DELETE = "delete"
    end
  end
end
