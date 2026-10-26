# frozen_string_literal: true

module Schematic
  module Types
    class CatalogDetailResponseData < Internal::Types::Model
      field :capabilities, -> { Schematic::Types::CatalogCapabilitiesResponseData }, optional: false, nullable: false

      field :custom_plan_cta, -> { Schematic::Types::CatalogCustomPlanCtaResponseData }, optional: true, nullable: false

      field :default_currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :description, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :pricing_model, -> { String }, optional: true, nullable: false

      field :pricing_url, -> { String }, optional: true, nullable: false
    end
  end
end
