# frozen_string_literal: true

module Schematic
  module Types
    class StripeIntegrationConfig < Internal::Types::Model
      field :account_id, -> { String }, optional: true, nullable: false
      field :account_name, -> { String }, optional: true, nullable: false
      field :company_update_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :is_sandbox, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :live_mode, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :onboard_url, -> { String }, optional: true, nullable: false
    end
  end
end
