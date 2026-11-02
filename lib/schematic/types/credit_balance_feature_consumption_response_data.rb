# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditBalanceFeatureConsumptionResponseData < Internal::Types::Model
      field :amount, -> { Float }, optional: false, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :feature_name, -> { String }, optional: false, nullable: false
    end
  end
end
