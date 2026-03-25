# frozen_string_literal: true

module Schematic
  module Types
    class UpsertUserSubRequestBody < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false
      field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
      field :id, -> { String }, optional: true, nullable: false
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :update_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
