# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditModelRate < Internal::Types::Model
      field :consumption_rate, -> { Float }, optional: false, nullable: false

      field :model, -> { String }, optional: false, nullable: false

      field :provider, -> { String }, optional: false, nullable: false

      field :quantity_rates, -> { Internal::Types::Hash[String, Float] }, optional: true, nullable: false
    end
  end
end
