# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Customplangrouprollouts
    module Types
      # Input parameters
      class PreviewGroupRolloutParams < Internal::Types::Model
        field :from_plan_version_id, -> { String }, optional: true, nullable: false

        field :to_plan_version_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
