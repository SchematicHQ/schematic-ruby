# frozen_string_literal: true

module Schematic
  module Types
    module CompanyFeatureUsageExportMetadataVisibleColumnsItem
      extend Schematic::Internal::Types::Enum

      PLAN = "plan"
      SUBSCRIPTION = "subscription"
      USERS = "users"
      LAST_SEEN_AT = "last_seen_at"
    end
  end
end
