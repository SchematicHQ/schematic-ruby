# frozen_string_literal: true

module Schematic
  module Types
    module DataExportType
      extend Schematic::Internal::Types::Enum

      AUDIT_LOG = "audit-log"
      COMPANY_FEATURE_USAGE = "company-feature-usage"
    end
  end
end
