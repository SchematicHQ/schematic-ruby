# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListCompanyGrantsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingCreditGrantResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Credits::Types::ListCompanyGrantsParams }, optional: false, nullable: false
      end
    end
  end
end
