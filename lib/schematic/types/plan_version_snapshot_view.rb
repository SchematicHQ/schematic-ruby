# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionSnapshotView < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: false, nullable: false
    end
  end
end
