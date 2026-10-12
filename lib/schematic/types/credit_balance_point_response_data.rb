# frozen_string_literal: true

module Schematic
  module Types
    class CreditBalancePointResponseData < Internal::Types::Model
      field :balance, -> { Float }, optional: false, nullable: false

      field :consumed, -> { Float }, optional: false, nullable: false

      field :consumed_by_feature, -> { Internal::Types::Array[Schematic::Types::CreditBalanceFeatureConsumptionResponseData] }, optional: false, nullable: false

      field :timestamp, -> { String }, optional: false, nullable: false
    end
  end
end
