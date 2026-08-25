# frozen_string_literal: true

module Schematic
  module Licenses
    module Types
      class CountLicensesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Licenses::Types::CountLicensesParams }, optional: false, nullable: false
      end
    end
  end
end
