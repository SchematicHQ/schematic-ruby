# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class MrrResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false
    end
  end
end
