# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UpdateBillingSettingsRequestBody < Internal::Types::Model
        field :default_provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
      end
    end
  end
end
