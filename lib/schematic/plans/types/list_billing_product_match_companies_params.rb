# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      # Input parameters
      class ListBillingProductMatchCompaniesParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
