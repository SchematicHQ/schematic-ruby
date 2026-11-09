# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ContractPostpaidResponseData < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::ContractPostpaidCreditResponseData] }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :owed, -> { Integer }, optional: false, nullable: false
    end
  end
end
