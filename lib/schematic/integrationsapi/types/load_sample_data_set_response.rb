# frozen_string_literal: true

require_relative "../../../schematic"

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
