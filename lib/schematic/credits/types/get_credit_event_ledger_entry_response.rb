# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class GetCreditEventLedgerEntryResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CreditEventLedgerResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
