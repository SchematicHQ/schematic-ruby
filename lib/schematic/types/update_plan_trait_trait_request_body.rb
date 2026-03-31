# frozen_string_literal: true

module Schematic
  module Types
    class UpdatePlanTraitTraitRequestBody < Internal::Types::Model
      field :trait_id, -> { String }, optional: false, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
    end
  end
end
