# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Integrationsapi
    module Types
      class InstallStripeClaimableSandboxResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::StripeSandboxInstallResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
