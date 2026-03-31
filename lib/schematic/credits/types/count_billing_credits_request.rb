# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CountBillingCreditsRequest < Internal::Types::Model
        field :ids, -> { String }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
