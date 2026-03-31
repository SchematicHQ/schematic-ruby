# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListEnvironmentsRequest < Internal::Types::Model
        field :ids, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
