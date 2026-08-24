# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class LoadSampleDataSetResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::IntegrationsDataSetResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
