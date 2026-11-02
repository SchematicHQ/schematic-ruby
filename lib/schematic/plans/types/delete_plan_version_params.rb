# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      # Input parameters
      class DeletePlanVersionParams < Internal::Types::Model
        field :promote_archived_version, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
