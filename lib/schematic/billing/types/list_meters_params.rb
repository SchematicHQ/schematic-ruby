# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      # Input parameters
      class ListMetersParams < Internal::Types::Model
        field :display_name, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
