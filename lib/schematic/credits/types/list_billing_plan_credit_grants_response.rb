# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class ListBillingPlanCreditGrantsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingPlanCreditGrantResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::ListBillingPlanCreditGrantsParams }, optional: false, nullable: false
      end
    end
  end
end
