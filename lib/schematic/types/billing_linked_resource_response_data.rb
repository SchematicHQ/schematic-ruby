# frozen_string_literal: true

module Schematic
  module Types
    class BillingLinkedResourceResponseData < Internal::Types::Model
      field :billing_provider, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :external_resource_id, -> { String }, optional: false, nullable: false
      field :originator, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
    end
  end
end
