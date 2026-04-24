# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class GetAccountMemberResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::AccountMemberResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
