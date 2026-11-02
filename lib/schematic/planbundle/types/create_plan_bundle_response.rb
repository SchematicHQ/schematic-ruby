# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Planbundle
    module Types
      class CreatePlanBundleResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanBundleResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
