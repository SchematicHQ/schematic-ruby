# frozen_string_literal: true

module Schematic
  module Types
    class StripeSandboxInstallResponseData < Internal::Types::Model
      field :api_keys, -> { Schematic::Types::StripeSandboxKeysResponseData }, optional: true, nullable: false

      field :claim_url, -> { String }, optional: false, nullable: false

      field :claim_url_expires_at, -> { String }, optional: true, nullable: false

      field :expires_at, -> { String }, optional: true, nullable: false

      field :install, -> { Schematic::Types::IntegrationInstallResponseData }, optional: false, nullable: false

      field :sandbox_id, -> { String }, optional: false, nullable: false

      field :stripe_account_id, -> { String }, optional: false, nullable: false
    end
  end
end
