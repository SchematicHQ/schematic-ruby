# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module SlackConnectInviteStatus
      extend Schematic::Internal::Types::Enum

      ACCEPTED = "accepted"
      DECLINED = "declined"
      DISMISSED = "dismissed"
      EXPIRED = "expired"
      PENDING = "pending"
    end
  end
end
