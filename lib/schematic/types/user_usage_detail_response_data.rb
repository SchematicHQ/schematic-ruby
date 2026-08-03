# frozen_string_literal: true

module Schematic
  module Types
    class UserUsageDetailResponseData < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::UserCreditUsageResponseData] }, optional: false, nullable: false
      field :daily_credit_points, -> { Internal::Types::Array[Schematic::Types::UserDailyCreditPointResponseData] }, optional: false, nullable: false
      field :daily_points, -> { Internal::Types::Array[Schematic::Types::UserDailyUsagePointResponseData] }, optional: false, nullable: false
      field :end_time, -> { String }, optional: false, nullable: false
      field :feature_totals, -> { Internal::Types::Array[Schematic::Types::UserFeatureUsageResponseData] }, optional: false, nullable: false
      field :start_time, -> { String }, optional: false, nullable: false
      field :user, -> { Schematic::Types::UserResponseData }, optional: true, nullable: false
    end
  end
end
