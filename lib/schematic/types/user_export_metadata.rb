# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    # Exports one row per user, oldest first. Omitting every filter exports every user in the environment.
    class UserExportMetadata < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false

      field :entity_key_definition_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :entity_trait_definition_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :q, -> { String }, optional: true, nullable: false
    end
  end
end
