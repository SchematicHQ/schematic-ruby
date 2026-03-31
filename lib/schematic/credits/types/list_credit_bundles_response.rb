# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListCreditBundlesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingCreditBundleResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Credits::Types::ListCreditBundlesParams }, optional: false, nullable: false
      end
    end
  end
end
