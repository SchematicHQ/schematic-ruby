# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutFieldWithValue < Internal::Types::Model
      field :definition_id, -> { String }, optional: false, nullable: false

      field :helper_text, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :required, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :stripe_metadata_key, -> { String }, optional: false, nullable: false

      field :value, -> { String }, optional: true, nullable: false
    end
  end
end
