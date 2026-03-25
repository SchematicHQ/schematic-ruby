# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class GetEventSummariesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EventSummaryResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Events::Types::GetEventSummariesParams }, optional: false, nullable: false
      end
    end
  end
end
