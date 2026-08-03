# frozen_string_literal: true

module Schematic
  module Types
    class UserDailyUsagePointResponseData < Internal::Types::Model
      field :date, -> { String }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false
      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
