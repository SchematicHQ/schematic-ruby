# frozen_string_literal: true

module Schematic
  module Types
    class PlanTraitResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :plan_type, -> { String }, optional: false, nullable: false
      field :trait_id, -> { String }, optional: false, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
