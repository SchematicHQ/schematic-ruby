# frozen_string_literal: true

module Schematic
  module Types
    class BillingMeterResponseData < Internal::Types::Model
      field :dispaly_name, -> { String }, optional: false, nullable: false
      field :event_name, -> { String }, optional: false, nullable: false
      field :event_payload_key, -> { String }, optional: false, nullable: false
      field :external_price_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
    end
  end
end
