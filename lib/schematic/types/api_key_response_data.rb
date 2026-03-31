# frozen_string_literal: true

module Schematic
  module Types
    class ApiKeyResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :last_used_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :readonly, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :scopes, -> { Internal::Types::Array[Schematic::Types::ApiKeyScope] }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
