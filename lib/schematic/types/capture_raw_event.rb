# frozen_string_literal: true

module Schematic
  module Types
    class CaptureRawEvent < Internal::Types::Model
      field :captured_at, -> { String }, optional: false, nullable: false
      field :event_id, -> { String }, optional: true, nullable: false
      field :raw_bytes, -> { String }, optional: false, nullable: false
      field :remote_ip, -> { String }, optional: false, nullable: false
      field :user_agent, -> { String }, optional: false, nullable: false
    end
  end
end
