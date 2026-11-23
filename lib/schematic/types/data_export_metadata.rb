# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class DataExportMetadata < Internal::Types::Model
      extend Schematic::Internal::Types::Union

      discriminant :export_type

      member -> { Schematic::Types::AuditLogExportMetadata }, key: "AUDIT_LOG"

      member -> { Schematic::Types::CompanyFeatureUsageExportMetadata }, key: "COMPANY_FEATURE_USAGE"

      member -> { Schematic::Types::CreditBalanceExportMetadata }, key: "CREDIT_BALANCE"

      member -> { Schematic::Types::CreditLedgerExportMetadata }, key: "CREDIT_LEDGER"

      member -> { Schematic::Types::EventExportMetadata }, key: "EVENT"

      member -> { Schematic::Types::UserExportMetadata }, key: "USER"
    end
  end
end
