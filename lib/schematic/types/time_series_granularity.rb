# frozen_string_literal: true

module Schematic
  module Types
    module TimeSeriesGranularity
      extend Schematic::Internal::Types::Enum

      DAILY = "daily"
      HOURLY = "hourly"
      MONTHLY = "monthly"
      WEEKLY = "weekly"
    end
  end
end
