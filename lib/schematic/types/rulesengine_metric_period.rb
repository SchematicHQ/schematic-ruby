# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module RulesengineMetricPeriod
      extend Schematic::Internal::Types::Enum

      ALL_TIME = "all_time"
      CURRENT_DAY = "current_day"
      CURRENT_MONTH = "current_month"
      CURRENT_WEEK = "current_week"
    end
  end
end
