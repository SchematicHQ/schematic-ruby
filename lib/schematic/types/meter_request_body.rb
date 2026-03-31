# frozen_string_literal: true

module Schematic
  module Types
    class MeterRequestBody < Internal::Types::Model
      field :display_name, -> { String }, optional: false, nullable: false
      field :event_name, -> { String }, optional: false, nullable: false
      field :event_payload_key, -> { String }, optional: false, nullable: false
    end
  end
end
