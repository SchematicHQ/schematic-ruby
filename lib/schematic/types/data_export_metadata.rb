# frozen_string_literal: true

module Schematic
  module Types
    class DataExportMetadata < Internal::Types::Model
      extend Schematic::Internal::Types::Union

      discriminant :export_type

      member -> { Schematic::Types::AuditLogExportMetadata }, key: "AUDIT_LOG"
      member -> { Schematic::Types::CompanyFeatureUsageExportMetadata }, key: "COMPANY_FEATURE_USAGE"
    end
  end
end
