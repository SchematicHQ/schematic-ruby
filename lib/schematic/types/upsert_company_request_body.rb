# frozen_string_literal: true

module Schematic
  module Types
    class UpsertCompanyRequestBody < Internal::Types::Model
      field :id, -> { String }, optional: true, nullable: false
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :prevent_key_remap, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :update_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
