# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionBillingProductChangeResponseData < Internal::Types::Model
      field :new, -> { Schematic::Types::BillingProductDetailResponseData }, optional: true, nullable: false

      field :old, -> { Schematic::Types::BillingProductDetailResponseData }, optional: true, nullable: false
    end
  end
end
