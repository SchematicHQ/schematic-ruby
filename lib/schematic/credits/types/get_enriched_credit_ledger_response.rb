# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetEnrichedCreditLedgerResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CreditLedgerEnrichedEntryResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Credits::Types::GetEnrichedCreditLedgerParams }, optional: false, nullable: false
      end
    end
  end
end
