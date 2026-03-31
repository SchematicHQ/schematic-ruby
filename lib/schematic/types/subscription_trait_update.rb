# frozen_string_literal: true

module Schematic
  module Types
    class SubscriptionTraitUpdate < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false
      field :hierarchy, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :trait_id, -> { String }, optional: false, nullable: false
      field :trait_name, -> { String }, optional: false, nullable: false
      field :trait_type, -> { Schematic::Types::TraitType }, optional: false, nullable: false
      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
