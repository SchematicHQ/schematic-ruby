# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class CountBillingProductMatchCompaniesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::CountBillingProductMatchCompaniesParams }, optional: false, nullable: false
      end
    end
  end
end
