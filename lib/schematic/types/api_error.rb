# frozen_string_literal: true

module Schematic
  module Types
    class ApiError < Internal::Types::Model
      field :error, -> { String }, optional: false, nullable: false
    end
  end
end
