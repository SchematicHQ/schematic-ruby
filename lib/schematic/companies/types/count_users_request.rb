# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountUsersRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :ids, -> { String }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
