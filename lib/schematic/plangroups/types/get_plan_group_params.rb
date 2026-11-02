# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plangroups
    module Types
      # Input parameters
      class GetPlanGroupParams < Internal::Types::Model
        field :include_company_counts, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
