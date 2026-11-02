# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanVersionFieldChangeResponseData < Internal::Types::Model
      field :field, -> { String }, optional: false, nullable: false

      field :new, -> { String }, optional: false, nullable: false

      field :old, -> { String }, optional: false, nullable: false
    end
  end
end
