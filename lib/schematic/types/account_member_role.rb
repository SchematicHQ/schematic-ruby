# frozen_string_literal: true

module Schematic
  module Types
    module AccountMemberRole
      extend Schematic::Internal::Types::Enum

      ADMIN = "admin"
      MEMBER = "member"
    end
  end
end
