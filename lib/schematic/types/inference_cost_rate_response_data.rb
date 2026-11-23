# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class InferenceCostRateResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false

      field :currency, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :pinned, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :provider, -> { String }, optional: false, nullable: false

      field :rates, -> { Internal::Types::Hash[String, Float] }, optional: false, nullable: false

      field :repriced_at, -> { String }, optional: true, nullable: false

      field :response_model, -> { String }, optional: false, nullable: false

      field :scope, -> { Schematic::Types::InferenceCostRateScope }, optional: false, nullable: false

      field :starting_at, -> { String }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
