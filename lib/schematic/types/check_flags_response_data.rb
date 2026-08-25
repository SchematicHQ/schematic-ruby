# frozen_string_literal: true

module Schematic
  module Types
    class CheckFlagsResponseData < Internal::Types::Model
      field :credit_balances, -> { Internal::Types::Hash[String, Schematic::Types::CompanyCreditBalance] }, optional: true, nullable: false

      field :flags, -> { Internal::Types::Array[Schematic::Types::CheckFlagResponseData] }, optional: false, nullable: false

      field :plan, -> { Schematic::Types::DatastreamCompanyPlan }, optional: true, nullable: false
    end
  end
end
