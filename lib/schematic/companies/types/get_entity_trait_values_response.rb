# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetEntityTraitValuesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EntityTraitValue] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::GetEntityTraitValuesParams }, optional: false, nullable: false
      end
    end
  end
end
