# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      # Input parameters
      class GetCompanyInferenceCostParams < Internal::Types::Model
        field :end_time, -> { String }, optional: true, nullable: false

        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
