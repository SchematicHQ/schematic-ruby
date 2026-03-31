# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListBillingCreditsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingCreditResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Credits::Types::ListBillingCreditsParams }, optional: false, nullable: false
      end
    end
  end
end
