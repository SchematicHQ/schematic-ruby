# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class ListPlanIssuesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanIssueResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::ListPlanIssuesParams }, optional: false, nullable: false
      end
    end
  end
end
