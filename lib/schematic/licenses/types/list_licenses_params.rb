# frozen_string_literal: true

module Schematic
  module Licenses
    module Types
      # Input parameters
      class ListLicensesParams < Internal::Types::Model
        field :feature_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :name, -> { String }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
