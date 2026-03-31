# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      # Input parameters
      class ListCustomersWithSubscriptionsParams < Internal::Types::Model
        field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
