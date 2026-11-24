# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    # Rows are consistent within a page of 250 companies. The As Of column marks when the export started; in a large
    # environment, later pages may include usage recorded after that time.
    class CreditBalanceExportMetadata < Internal::Types::Model
      field :billing_credit_id, -> { String }, optional: true, nullable: false

      field :company_id, -> { String }, optional: true, nullable: false

      field :notification_email_recipient_email_addresses, -> { Internal::Types::Array[String] }, optional: true, nullable: false
    end
  end
end
