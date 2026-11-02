# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingCreditLedgerResponseData < Internal::Types::Model
      field :description, -> { String }, optional: true, nullable: false

      field :icon, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :plural_name, -> { String }, optional: true, nullable: false

      field :singular_name, -> { String }, optional: true, nullable: false
    end
  end
end
