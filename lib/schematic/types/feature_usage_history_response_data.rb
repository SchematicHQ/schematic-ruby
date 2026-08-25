# frozen_string_literal: true

module Schematic
  module Types
    class FeatureUsageHistoryResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :event_subtype, -> { String }, optional: false, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :usage, -> { Integer }, optional: false, nullable: false
    end
  end
end
