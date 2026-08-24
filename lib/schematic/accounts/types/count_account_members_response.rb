# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class CountAccountMembersResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Accounts::Types::CountAccountMembersParams }, optional: false, nullable: false
      end
    end
  end
end
