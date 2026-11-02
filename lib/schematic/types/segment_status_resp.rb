# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class SegmentStatusResp < Internal::Types::Model
      field :connected, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :environment_id, -> { String }, optional: false, nullable: false

      field :last_event_at, -> { String }, optional: true, nullable: false
    end
  end
end
