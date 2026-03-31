# frozen_string_literal: true

module Schematic
  module Types
    class UserResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
