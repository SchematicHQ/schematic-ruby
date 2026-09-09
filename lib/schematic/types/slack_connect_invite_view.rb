# frozen_string_literal: true

module Schematic
  module Types
    class SlackConnectInviteView < Internal::Types::Model
      field :can_resend_at, -> { String }, optional: true, nullable: false

      field :email, -> { String }, optional: false, nullable: false

      field :sent_at, -> { String }, optional: false, nullable: false

      field :status, -> { Schematic::Types::SlackConnectInviteStatus }, optional: false, nullable: false
    end
  end
end
