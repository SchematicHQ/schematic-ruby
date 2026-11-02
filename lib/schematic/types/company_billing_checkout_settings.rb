# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyBillingCheckoutSettings < Internal::Types::Model
      field :collect_address, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :collect_email, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :collect_phone, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :collect_tax_id, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
