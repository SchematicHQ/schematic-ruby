# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListCompanyCreditBalancesRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
