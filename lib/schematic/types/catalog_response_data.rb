# frozen_string_literal: true

module Schematic
  module Types
    class CatalogResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :custom_plan_cta_text, -> { String }, optional: true, nullable: false

      field :custom_plan_cta_url, -> { String }, optional: true, nullable: false

      field :custom_plan_price_text, -> { String }, optional: true, nullable: false

      field :custom_plans_visible, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :description, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :is_default, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :pricing_model, -> { String }, optional: true, nullable: false

      field :pricing_url, -> { String }, optional: true, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
