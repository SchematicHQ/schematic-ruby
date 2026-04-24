# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListAccountMembersResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::AccountMemberResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Accounts::Types::ListAccountMembersParams }, optional: false, nullable: false
      end
    end
  end
end
