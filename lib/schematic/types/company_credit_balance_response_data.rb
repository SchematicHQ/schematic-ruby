# frozen_string_literal: true

module Schematic
  module Types
    class CompanyCreditBalanceResponseData < Internal::Types::Model
      field :credit_id, -> { String }, optional: false, nullable: false
      field :remaining, -> { Integer }, optional: false, nullable: false
      field :source, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :total, -> { Integer }, optional: true, nullable: false
    end
  end
end
