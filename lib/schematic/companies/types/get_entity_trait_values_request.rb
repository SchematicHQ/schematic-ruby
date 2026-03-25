# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetEntityTraitValuesRequest < Internal::Types::Model
        field :definition_id, -> { String }, optional: false, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
