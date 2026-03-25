# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CountBillingCreditsGrantsRequest < Internal::Types::Model
        field :credit_id, -> { String }, optional: true, nullable: false
        field :ids, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
