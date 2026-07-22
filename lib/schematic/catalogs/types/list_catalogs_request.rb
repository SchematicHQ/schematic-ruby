# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class ListCatalogsRequest < Internal::Types::Model
        field :is_default, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
