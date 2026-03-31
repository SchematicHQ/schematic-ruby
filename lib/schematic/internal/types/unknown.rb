# frozen_string_literal: true

module Schematic
  module Internal
    module Types
      module Unknown
        include Schematic::Internal::Types::Type

        def coerce(value)
          value
        end
      end
    end
  end
end
