# frozen_string_literal: true

module Schematic
  module Plangroups
    module Types
      class GetPlanGroupRequest < Internal::Types::Model
        field :include_company_counts, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
