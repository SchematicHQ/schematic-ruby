# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class ListIntegrationsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::IntegrationsListResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Integrationsapi::Types::ListIntegrationsParams }, optional: false, nullable: false
      end
    end
  end
end
