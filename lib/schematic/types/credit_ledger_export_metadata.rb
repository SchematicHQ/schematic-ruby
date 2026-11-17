# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditLedgerExportMetadata < Internal::Types::Model
      field :billing_credit_id, -> { String }, optional: true, nullable: false

      field :company_id, -> { String }, optional: true, nullable: false

      field :end_time, -> { String }, optional: true, nullable: false

      field :event_type, -> { Schematic::Types::CreditLedgerExportMetadataEventType }, optional: true, nullable: false

      field :feature_id, -> { String }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :source_event_id, -> { String }, optional: true, nullable: false

      field :start_time, -> { String }, optional: true, nullable: false
    end
  end
end
