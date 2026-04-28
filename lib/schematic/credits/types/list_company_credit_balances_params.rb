# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      # Input parameters
      class ListCompanyCreditBalancesParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
