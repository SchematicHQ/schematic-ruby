# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutFieldInput < Internal::Types::Model
      field :definition_id, -> { String }, optional: true, nullable: false

      field :helper_text, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: true, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :required, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :stripe_metadata_key, -> { String }, optional: false, nullable: false
    end
  end
end
