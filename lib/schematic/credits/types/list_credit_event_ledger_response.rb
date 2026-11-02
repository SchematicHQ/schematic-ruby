# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class ListCreditEventLedgerResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CreditEventLedgerResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::ListCreditEventLedgerParams }, optional: false, nullable: false
      end
    end
  end
end
