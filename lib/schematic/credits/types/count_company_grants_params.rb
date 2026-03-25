# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      # Input parameters
      class CountCompanyGrantsParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :dir, -> { Schematic::Types::SortDirection }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :order, -> { Schematic::Types::CreditGrantSortOrder }, optional: true, nullable: false
      end
    end
  end
end
