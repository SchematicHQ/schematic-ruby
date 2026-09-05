# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class GetStripeSandboxKeysResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ClaimedStripeSandboxKeysResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
