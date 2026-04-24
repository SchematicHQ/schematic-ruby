# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class CountBillingProductMatchCompaniesRequest < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
