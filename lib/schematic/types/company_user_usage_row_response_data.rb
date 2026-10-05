# frozen_string_literal: true

module Schematic
  module Types
    class CompanyUserUsageRowResponseData < Internal::Types::Model
      field :last_seen, -> { String }, optional: true, nullable: false

      field :share, -> { Integer }, optional: false, nullable: false

      field :user, -> { Schematic::Types::UserResponseData }, optional: true, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false

      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
