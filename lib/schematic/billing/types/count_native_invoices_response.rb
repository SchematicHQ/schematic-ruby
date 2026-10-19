# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CountNativeInvoicesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::CountNativeInvoicesParams }, optional: false, nullable: false
      end
    end
  end
end
