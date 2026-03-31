# frozen_string_literal: true

module Schematic
  module Types
    class EnvironmentResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_type, -> { Schematic::Types::EnvironmentType }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
