# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetCreditBalanceTimeSeriesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CreditBalanceTimeSeriesResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::GetCreditBalanceTimeSeriesParams }, optional: false, nullable: false
      end
    end
  end
end
