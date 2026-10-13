# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionFieldChangeResponseData < Internal::Types::Model
      field :field, -> { String }, optional: false, nullable: false

      field :new, -> { String }, optional: false, nullable: false

      field :old, -> { String }, optional: false, nullable: false
    end
  end
end
