# frozen_string_literal: true

module Schematic
  module Types
    class CreditBundlePurchaseResponseData < Internal::Types::Model
      field :bundle, -> { Schematic::Types::BillingCreditBundleResponseData }, optional: true, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :total, -> { Integer }, optional: false, nullable: false
    end
  end
end
