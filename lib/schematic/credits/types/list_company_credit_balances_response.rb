# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class ListCompanyCreditBalancesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyCreditBalanceResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::ListCompanyCreditBalancesParams }, optional: false, nullable: false
      end
    end
  end
end
