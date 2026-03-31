# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class ListAuditLogsRequest < Internal::Types::Model
        field :actor_type, -> { Schematic::Types::ActorType }, optional: true, nullable: false
        field :end_time, -> { String }, optional: true, nullable: false
        field :environment_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
