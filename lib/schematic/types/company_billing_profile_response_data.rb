# frozen_string_literal: true

module Schematic
  module Types
    class CompanyBillingProfileResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false

      field :billing_customer_id, -> { String }, optional: true, nullable: false

      field :collection_method, -> { Schematic::Types::BillingCollectionMethod }, optional: false, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :days_until_due, -> { Integer }, optional: true, nullable: false

      field :environment_id, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :is_default, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :name, -> { String }, optional: true, nullable: false

      field :payment_method_id, -> { String }, optional: true, nullable: false

      field :proration_behavior, -> { Schematic::Types::ProrationBehavior }, optional: true, nullable: false

      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
