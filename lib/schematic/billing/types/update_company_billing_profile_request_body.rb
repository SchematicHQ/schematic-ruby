# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UpdateCompanyBillingProfileRequestBody < Internal::Types::Model
        field :billing_profile_id, -> { String }, optional: false, nullable: false

        field :collection_method, -> { Schematic::Types::BillingCollectionMethod }, optional: false, nullable: false

        field :days_until_due, -> { Integer }, optional: true, nullable: false

        field :is_default, -> { Internal::Types::Boolean }, optional: true, nullable: false

        field :name, -> { String }, optional: true, nullable: false

        field :payment_method_id, -> { String }, optional: true, nullable: false

        field :proration_behavior, -> { Schematic::Types::ProrationBehavior }, optional: true, nullable: false
      end
    end
  end
end
