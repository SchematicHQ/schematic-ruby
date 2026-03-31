# frozen_string_literal: true

module Schematic
  module Planbundle
    module Types
      class UpdatePlanBundleResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanBundleResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
