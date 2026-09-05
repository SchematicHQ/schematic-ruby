# frozen_string_literal: true

module Schematic
  module Types
    class OtlpEnvironmentSettingsResponseData < Internal::Types::Model
      field :company_attribute, -> { String }, optional: true, nullable: false

      field :company_key, -> { String }, optional: true, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :environment_id, -> { String }, optional: false, nullable: false

      field :tool_events_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false

      field :user_attribute, -> { String }, optional: true, nullable: false

      field :user_key, -> { String }, optional: true, nullable: false
    end
  end
end
