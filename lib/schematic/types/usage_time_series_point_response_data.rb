# frozen_string_literal: true

module Schematic
  module Types
    class UsageTimeSeriesPointResponseData < Internal::Types::Model
      field :period_end, -> { String }, optional: true, nullable: false
      field :period_start, -> { String }, optional: true, nullable: false
      field :timestamp, -> { String }, optional: false, nullable: false
      field :usage, -> { Integer }, optional: false, nullable: false
    end
  end
end
