# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreateBillingProductRequestBody < Internal::Types::Model
        field :external_id, -> { String }, optional: false, nullable: false
        field :is_active, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :price, -> { Integer }, optional: false, nullable: false
        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
      end
    end
  end
end
