# frozen_string_literal: true

module Schematic
  module Types
    class EnvironmentDetailResponseData < Internal::Types::Model
      field :api_keys, -> { Internal::Types::Array[Schematic::Types::ApiKeyResponseData] }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_type, -> { Schematic::Types::EnvironmentType }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
