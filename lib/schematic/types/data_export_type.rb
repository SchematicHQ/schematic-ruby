# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module DataExportType
      extend Schematic::Internal::Types::Enum

      AUDIT_LOG = "audit-log"
      COMPANY_FEATURE_USAGE = "company-feature-usage"
      EVENT = "event"
    end
  end
end
