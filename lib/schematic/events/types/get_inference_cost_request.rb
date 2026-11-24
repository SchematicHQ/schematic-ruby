# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class GetInferenceCostRequest < Internal::Types::Model
        field :end_time, -> { String }, optional: true, nullable: false

        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
