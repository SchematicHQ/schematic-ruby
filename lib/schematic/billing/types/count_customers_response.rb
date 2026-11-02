# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class CountCustomersResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::CountCustomersParams }, optional: false, nullable: false
      end
    end
  end
end
