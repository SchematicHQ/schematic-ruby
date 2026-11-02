# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Accounts
    module Types
      class CountAuditLogsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Accounts::Types::CountAuditLogsParams }, optional: false, nullable: false
      end
    end
  end
end
