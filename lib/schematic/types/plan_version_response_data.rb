# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :original_plan_id, -> { String }, optional: true, nullable: false
      field :plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
      field :status, -> { Schematic::Types::PlanVersionStatus }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: false, nullable: false
    end
  end
end
