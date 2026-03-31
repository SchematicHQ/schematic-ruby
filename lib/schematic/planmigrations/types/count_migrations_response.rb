# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class CountMigrationsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Planmigrations::Types::CountMigrationsParams }, optional: false, nullable: false
      end
    end
  end
end
