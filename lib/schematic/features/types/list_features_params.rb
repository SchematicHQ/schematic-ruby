# frozen_string_literal: true

module Schematic
  module Features
    module Types
      # Input parameters
      class ListFeaturesParams < Internal::Types::Model
        field :boolean_require_event, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :feature_type, -> { Internal::Types::Array[Schematic::Types::FeatureType] }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :without_company_override_for, -> { String }, optional: true, nullable: false
        field :without_plan_entitlement_for, -> { String }, optional: true, nullable: false
      end
    end
  end
end
