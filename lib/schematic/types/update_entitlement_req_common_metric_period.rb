# frozen_string_literal: true

module Schematic
  module Types
    module UpdateEntitlementReqCommonMetricPeriod
      extend Schematic::Internal::Types::Enum

      ALL_TIME = "all_time"
      CURRENT_MONTH = "current_month"
      CURRENT_WEEK = "current_week"
      CURRENT_DAY = "current_day"
    end
  end
end
