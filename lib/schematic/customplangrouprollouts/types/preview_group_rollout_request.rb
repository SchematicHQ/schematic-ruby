# frozen_string_literal: true

module Schematic
  module Customplangrouprollouts
    module Types
      class PreviewGroupRolloutRequest < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false

        field :from_plan_version_id, -> { String }, optional: true, nullable: false

        field :to_plan_version_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
