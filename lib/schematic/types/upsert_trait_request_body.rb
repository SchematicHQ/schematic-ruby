# frozen_string_literal: true

module Schematic
  module Types
    class UpsertTraitRequestBody < Internal::Types::Model
      field :incr, -> { Integer }, optional: true, nullable: false
      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :set, -> { String }, optional: true, nullable: false
      field :trait, -> { String }, optional: false, nullable: false
      field :update_only, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
