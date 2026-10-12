# frozen_string_literal: true

module Schematic
  module Types
    class CreditBalanceTimeSeriesResponseData < Internal::Types::Model
      field :balance_points, -> { Internal::Types::Array[Schematic::Types::CreditBalancePointResponseData] }, optional: false, nullable: false

      field :billing_credit_id, -> { String }, optional: false, nullable: false

      field :events, -> { Internal::Types::Array[Schematic::Types::CreditBalanceEventResponseData] }, optional: false, nullable: false

      field :external, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
