# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CountResponse < Internal::Types::Model
      field :count, -> { Integer }, optional: true, nullable: false
    end
  end
end
