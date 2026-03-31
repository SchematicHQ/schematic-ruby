# frozen_string_literal: true

module Schematic
  module Types
    class CreditGrantDetail < Internal::Types::Model
      field :credit_type_icon, -> { String }, optional: true, nullable: false
      field :expires_at, -> { String }, optional: true, nullable: false
      field :grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
