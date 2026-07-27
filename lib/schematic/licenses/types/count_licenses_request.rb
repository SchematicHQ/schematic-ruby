# frozen_string_literal: true

module Schematic
  module Licenses
    module Types
      class CountLicensesRequest < Internal::Types::Model
        field :feature_ids, -> { String }, optional: true, nullable: false
        field :ids, -> { String }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
