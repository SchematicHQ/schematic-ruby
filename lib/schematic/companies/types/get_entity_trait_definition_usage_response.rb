# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class GetEntityTraitDefinitionUsageResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::EntityTraitDefinitionUsage }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
