# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class ListAccountInferenceCostRatesRequest < Internal::Types::Model
        field :provider, -> { String }, optional: true, nullable: false

        field :response_model, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
