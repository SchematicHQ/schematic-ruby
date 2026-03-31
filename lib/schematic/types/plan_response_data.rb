# frozen_string_literal: true

module Schematic
  module Types
    class PlanResponseData < Internal::Types::Model
      field :audience_type, -> { String }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
