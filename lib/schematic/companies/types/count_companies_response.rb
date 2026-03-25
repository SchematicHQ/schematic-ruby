# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountCompaniesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::CountCompaniesParams }, optional: false, nullable: false
      end
    end
  end
end
