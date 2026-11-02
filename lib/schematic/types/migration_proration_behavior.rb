# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module MigrationProrationBehavior
      extend Schematic::Internal::Types::Enum

      ALWAYS_INVOICE = "always_invoice"
      CREATE_PRORATIONS = "create_prorations"
      NONE = "none"
    end
  end
end
