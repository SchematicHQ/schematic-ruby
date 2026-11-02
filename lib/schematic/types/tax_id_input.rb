# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class TaxIdInput < Internal::Types::Model
      field :type, -> { Schematic::Types::TaxIdType }, optional: false, nullable: false

      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
