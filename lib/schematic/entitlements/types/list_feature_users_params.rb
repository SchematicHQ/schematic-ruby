# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class ListFeatureUsersParams < Internal::Types::Model
        field :feature_id, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
