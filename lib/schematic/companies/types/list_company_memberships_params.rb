# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class ListCompanyMembershipsParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :user_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
