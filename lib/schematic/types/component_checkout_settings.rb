# frozen_string_literal: true

module Schematic
  module Types
    class ComponentCheckoutSettings < Internal::Types::Model
      field :collect_address, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :collect_email, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :collect_phone, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :tax_collection_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
