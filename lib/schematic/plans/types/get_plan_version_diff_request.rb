# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class GetPlanVersionDiffRequest < Internal::Types::Model
        field :plan_version_id, -> { String }, optional: false, nullable: false

        field :against, -> { String }, optional: true, nullable: false
      end
    end
  end
end
