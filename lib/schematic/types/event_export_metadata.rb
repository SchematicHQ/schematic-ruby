# frozen_string_literal: true

module Schematic
  module Types
    class EventExportMetadata < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false

      field :end_time, -> { String }, optional: true, nullable: false

      field :event_subtype, -> { String }, optional: true, nullable: false

      field :event_types, -> { Internal::Types::Array[Schematic::Types::EventExportMetadataEventTypesItem] }, optional: true, nullable: false

      field :flag_id, -> { String }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :start_time, -> { String }, optional: true, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false
    end
  end
end
