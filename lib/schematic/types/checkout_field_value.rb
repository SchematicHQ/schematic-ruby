# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CheckoutFieldValue < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
