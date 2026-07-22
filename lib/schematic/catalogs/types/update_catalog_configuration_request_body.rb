# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class UpdateCatalogConfigurationRequestBody < Internal::Types::Model
        field :catalog_id, -> { String }, optional: false, nullable: false
        field :custom_plan_cta_text, -> { String }, optional: true, nullable: false
        field :custom_plan_cta_url, -> { String }, optional: true, nullable: false
        field :custom_plan_price_text, -> { String }, optional: true, nullable: false
        field :custom_plans_visible, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :ordered_add_ons, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedPlan] }, optional: true, nullable: false
        field :ordered_bundles, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedBundle] }, optional: true, nullable: false
        field :ordered_plans, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedPlan] }, optional: true, nullable: false
        field :pricing_model, -> { String }, optional: true, nullable: false
        field :pricing_url, -> { String }, optional: true, nullable: false
      end
    end
  end
end
