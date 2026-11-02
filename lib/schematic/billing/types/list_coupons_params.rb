# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      # Input parameters
      class ListCouponsParams < Internal::Types::Model
        field :is_active, -> { Internal::Types::Boolean }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
