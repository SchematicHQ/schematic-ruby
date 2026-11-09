# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingSettingsResponseData < Internal::Types::Model
      field :default_collector, -> { Schematic::Types::Collector }, optional: false, nullable: false

      field :default_provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false

      field :invoice_reply_to_email, -> { String }, optional: true, nullable: false
    end
  end
end
