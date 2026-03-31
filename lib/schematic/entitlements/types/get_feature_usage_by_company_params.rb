# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class GetFeatureUsageByCompanyParams < Internal::Types::Model
        field :keys, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      end
    end
  end
end
