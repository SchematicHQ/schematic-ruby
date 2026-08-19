# frozen_string_literal: true

module Schematic
  module Types
    module MigrationProrationBehavior
      extend Schematic::Internal::Types::Enum

      ALWAYS_INVOICE = "always_invoice"
      CREATE_PRORATIONS = "create_prorations"
    end
  end
end
