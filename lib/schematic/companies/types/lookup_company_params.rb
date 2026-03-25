# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class LookupCompanyParams < Internal::Types::Model
        field :keys, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      end
    end
  end
end
