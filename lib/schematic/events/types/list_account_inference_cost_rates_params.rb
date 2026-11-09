# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      # Input parameters
      class ListAccountInferenceCostRatesParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :provider, -> { String }, optional: true, nullable: false

        field :response_model, -> { String }, optional: true, nullable: false
      end
    end
  end
end
