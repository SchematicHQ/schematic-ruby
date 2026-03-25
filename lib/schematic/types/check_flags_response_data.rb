# frozen_string_literal: true

module Schematic
  module Types
    class CheckFlagsResponseData < Internal::Types::Model
      field :flags, -> { Internal::Types::Array[Schematic::Types::CheckFlagResponseData] }, optional: false, nullable: false
      field :plan, -> { Schematic::Types::DatastreamCompanyPlan }, optional: true, nullable: false
    end
  end
end
