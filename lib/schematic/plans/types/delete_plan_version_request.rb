# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class DeletePlanVersionRequest < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false
        field :promote_archived_version, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
