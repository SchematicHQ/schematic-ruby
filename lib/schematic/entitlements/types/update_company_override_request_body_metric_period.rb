# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      module UpdateCompanyOverrideRequestBodyMetricPeriod
        extend Schematic::Internal::Types::Enum

        ALL_TIME = "all_time"
        CURRENT_MONTH = "current_month"
        CURRENT_WEEK = "current_week"
        CURRENT_DAY = "current_day"
      end
    end
  end
end
