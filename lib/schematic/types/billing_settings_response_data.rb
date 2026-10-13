# frozen_string_literal: true

module Schematic
  module Types
    class BillingSettingsResponseData < Internal::Types::Model
      field :default_provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false
    end
  end
end
