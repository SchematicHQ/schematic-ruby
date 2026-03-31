# frozen_string_literal: true

module Schematic
  module Types
    class UpdatePlanRequestBody < Internal::Types::Model
      field :description, -> { String }, optional: true, nullable: false
      field :icon, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
