# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutFieldResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :definition_id, -> { String }, optional: false, nullable: false
      field :helper_text, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :position, -> { Integer }, optional: false, nullable: false
      field :required, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :stripe_metadata_key, -> { String }, optional: false, nullable: false
      field :trait_hierarchy, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
