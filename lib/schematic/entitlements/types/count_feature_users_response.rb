# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class CountFeatureUsersResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::CountFeatureUsersParams }, optional: false, nullable: false
      end
    end
  end
end
