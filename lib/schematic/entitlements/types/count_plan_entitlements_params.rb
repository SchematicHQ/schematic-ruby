# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class CountPlanEntitlementsParams < Internal::Types::Model
        field :feature_id, -> { String }, optional: true, nullable: false
        field :feature_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :plan_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :plan_version_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :with_metered_products, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
