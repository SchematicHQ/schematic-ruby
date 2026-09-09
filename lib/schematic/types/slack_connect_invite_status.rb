# frozen_string_literal: true

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
