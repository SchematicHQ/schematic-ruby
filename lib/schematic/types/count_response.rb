# frozen_string_literal: true

module Schematic
  module Types
    class CountResponse < Internal::Types::Model
      field :count, -> { Integer }, optional: true, nullable: false
    end
  end
end
