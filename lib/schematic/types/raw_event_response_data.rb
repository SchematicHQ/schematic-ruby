# frozen_string_literal: true

module Schematic
  module Types
    class RawEventResponseData < Internal::Types::Model
      field :captured_at, -> { String }, optional: false, nullable: false
      field :event_id, -> { String }, optional: true, nullable: false
      field :remote_addr, -> { String }, optional: true, nullable: false
      field :remote_ip, -> { String }, optional: false, nullable: false
      field :user_agent, -> { String }, optional: false, nullable: false
    end
  end
end
