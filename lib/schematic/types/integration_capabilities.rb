# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class IntegrationCapabilities < Internal::Types::Model
      field :author_plans, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :checkout, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :edit_billing, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
