# frozen_string_literal: true

module Schematic
  module Types
    class PlanSnapshotView < Internal::Types::Model
      field :deleted, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
