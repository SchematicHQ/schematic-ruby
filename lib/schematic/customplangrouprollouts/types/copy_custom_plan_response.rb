# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Customplangrouprollouts
    module Types
      class CopyCustomPlanResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanVersionResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
