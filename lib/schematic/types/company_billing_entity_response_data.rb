# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyBillingEntityResponseData < Internal::Types::Model
      field :billing_entity, -> { Schematic::Types::CompanyResponseData }, optional: true, nullable: false

      field :has_own_stripe_customer, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
