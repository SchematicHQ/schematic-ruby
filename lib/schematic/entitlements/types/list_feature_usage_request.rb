# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListFeatureUsageRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :company_keys, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
        field :feature_ids, -> { String }, optional: true, nullable: false
        field :include_usage_aggregation, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :without_negative_entitlements, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
