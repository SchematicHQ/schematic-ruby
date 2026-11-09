# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class CreateAccountInferenceCostRateRequestBody < Internal::Types::Model
        field :currency, -> { String }, optional: true, nullable: false

        field :provider, -> { String }, optional: false, nullable: false

        field :rates, -> { Internal::Types::Hash[String, Float] }, optional: false, nullable: false

        field :response_model, -> { String }, optional: false, nullable: false

        field :starting_at, -> { String }, optional: false, nullable: false
      end
    end
  end
end
