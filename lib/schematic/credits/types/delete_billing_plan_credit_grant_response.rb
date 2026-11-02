# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class DeleteBillingPlanCreditGrantResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Credits::Types::DeleteBillingPlanCreditGrantParams }, optional: false, nullable: false
      end
    end
  end
end
