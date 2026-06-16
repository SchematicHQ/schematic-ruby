# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutSettingsResponseData < Internal::Types::Model
      field :collect_address, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :collect_email, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :collect_phone, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :opt_in_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :opt_in_text, -> { String }, optional: true, nullable: false
      field :opt_in_title, -> { String }, optional: true, nullable: false
    end
  end
end
