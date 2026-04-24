# frozen_string_literal: true

module Schematic
  module Types
    class AuditLogListResponseData < Internal::Types::Model
      field :actor_type, -> { Schematic::Types::ActorType }, optional: false, nullable: false
      field :api_key_id, -> { String }, optional: true, nullable: false
      field :ended_at, -> { String }, optional: true, nullable: false
      field :environment, -> { Schematic::Types::EnvironmentResponseData }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :method_, -> { String }, optional: false, nullable: false, api_name: "method"
      field :resource_id, -> { Integer }, optional: true, nullable: false
      field :resource_id_string, -> { String }, optional: true, nullable: false
      field :resource_name, -> { String }, optional: true, nullable: false
      field :resource_type, -> { String }, optional: true, nullable: false
      field :resp_code, -> { Integer }, optional: true, nullable: false
      field :secondary_resource, -> { String }, optional: true, nullable: false
      field :started_at, -> { String }, optional: false, nullable: false
      field :url, -> { String }, optional: false, nullable: false
      field :user_name, -> { String }, optional: true, nullable: false
    end
  end
end
