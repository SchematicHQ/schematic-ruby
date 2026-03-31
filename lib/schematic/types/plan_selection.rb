# frozen_string_literal: true

module Schematic
  module Types
    class PlanSelection < Internal::Types::Model
      field :plan_id, -> { String }, optional: false, nullable: false
      field :price_id, -> { String }, optional: true, nullable: false
      field :version_id, -> { String }, optional: true, nullable: false
    end
  end
end
