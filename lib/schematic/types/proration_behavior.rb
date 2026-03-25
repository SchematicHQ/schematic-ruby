# frozen_string_literal: true

module Schematic
  module Types
    module ProrationBehavior
      extend Schematic::Internal::Types::Enum

      CREATE_PRORATIONS = "create_prorations"
      INVOICE_IMMEDIATELY = "invoice_immediately"
    end
  end
end
