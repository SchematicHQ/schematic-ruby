# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListAuditLogsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::AuditLogListResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Accounts::Types::ListAuditLogsParams }, optional: false, nullable: false
      end
    end
  end
end
