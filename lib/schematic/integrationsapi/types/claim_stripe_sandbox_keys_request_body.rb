# frozen_string_literal: true

module Schematic
  module Integrationsapi
    module Types
      class ClaimStripeSandboxKeysRequestBody < Internal::Types::Model
        field :token, -> { String }, optional: false, nullable: false
      end
    end
  end
end
