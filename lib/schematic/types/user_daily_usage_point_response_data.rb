# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class UserDailyUsagePointResponseData < Internal::Types::Model
      field :date, -> { String }, optional: false, nullable: false

      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false

      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
