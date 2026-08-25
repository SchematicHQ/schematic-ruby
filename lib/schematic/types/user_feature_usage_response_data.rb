# frozen_string_literal: true

module Schematic
  module Types
    class UserFeatureUsageResponseData < Internal::Types::Model
      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false

      field :last_seen, -> { String }, optional: false, nullable: false

      field :share, -> { Integer }, optional: false, nullable: false

      field :user, -> { Schematic::Types::UserResponseData }, optional: true, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false

      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
