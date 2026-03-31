# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetFeatureUsageByCompanyRequest < Internal::Types::Model
        field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      end
    end
  end
end
