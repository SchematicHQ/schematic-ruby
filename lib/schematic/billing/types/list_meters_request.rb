# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListMetersRequest < Internal::Types::Model
        field :display_name, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
