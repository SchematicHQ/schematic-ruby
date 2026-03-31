# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreateMeterRequestBody < Internal::Types::Model
        field :display_name, -> { String }, optional: false, nullable: false
        field :event_name, -> { String }, optional: false, nullable: false
        field :event_payload_key, -> { String }, optional: false, nullable: false
        field :external_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
