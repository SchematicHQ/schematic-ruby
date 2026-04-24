# frozen_string_literal: true

module Schematic
  module Types
    class FeatureResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :feature_type, -> { Schematic::Types::FeatureType }, optional: false, nullable: false
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :lifecycle_phase, -> { Schematic::Types::FeatureLifecyclePhase }, optional: true, nullable: false
      field :maintainer_account_member_id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plural_name, -> { String }, optional: true, nullable: false
      field :singular_name, -> { String }, optional: true, nullable: false
      field :trait_id, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
