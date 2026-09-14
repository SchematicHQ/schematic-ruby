# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class CheckAndReserveFlagRequestBody < Internal::Types::Model
        field :key, -> { String }, optional: false, nullable: false

        field :company, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false

        field :expires_at, -> { String }, optional: true, nullable: false

        field :preflight, -> { Schematic::Types::PreflightRequestBody }, optional: true, nullable: false

        field :quantity, -> { Integer }, optional: true, nullable: false

        field :user, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      end
    end
  end
end
