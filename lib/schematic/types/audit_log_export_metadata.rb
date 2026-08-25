# frozen_string_literal: true

module Schematic
  module Types
    class AuditLogExportMetadata < Internal::Types::Model
      field :actor_type, -> { String }, optional: true, nullable: false

      field :end_time, -> { String }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :q, -> { String }, optional: true, nullable: false

      field :start_time, -> { String }, optional: true, nullable: false
    end
  end
end
