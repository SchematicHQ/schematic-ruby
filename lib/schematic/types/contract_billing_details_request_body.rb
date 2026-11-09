# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ContractBillingDetailsRequestBody < Internal::Types::Model
      field :address, -> { Schematic::Types::CustomerBillingAddress }, optional: true, nullable: false

      field :email, -> { String }, optional: true, nullable: false

      field :legal_name, -> { String }, optional: true, nullable: false

      field :phone, -> { String }, optional: true, nullable: false

      field :tax_ids, -> { Internal::Types::Array[Schematic::Types::TaxIdInput] }, optional: false, nullable: false
    end
  end
end
