# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      class GetActivityResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ActivityResponseResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Insights::Types::GetActivityParams }, optional: false, nullable: false
      end
    end
  end
end
