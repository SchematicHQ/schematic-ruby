# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ContractPostpaidCreditResponseData < Internal::Types::Model
      field :counts_toward_limit, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :credit_id, -> { String }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :debt, -> { Float }, optional: false, nullable: false

      field :grant_cap, -> { Float }, optional: true, nullable: false

      field :owed, -> { Integer }, optional: true, nullable: false

      field :rate_per_unit, -> { String }, optional: true, nullable: false
    end
  end
end
