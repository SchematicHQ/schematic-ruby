# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanSelection < Internal::Types::Model
      field :plan_id, -> { String }, optional: false, nullable: false

      field :price_id, -> { String }, optional: true, nullable: false

      field :version_id, -> { String }, optional: true, nullable: false
    end
  end
end
