# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListCompanyBillingProfilesRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false

        field :is_default, -> { Internal::Types::Boolean }, optional: true, nullable: false

        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
