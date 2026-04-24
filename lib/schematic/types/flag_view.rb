# frozen_string_literal: true

module Schematic
  module Types
    class FlagView < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :default_value, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: true, nullable: false
      field :flag_type, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :last_checked_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :rules, -> { Internal::Types::Array[Schematic::Types::RuleView] }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
