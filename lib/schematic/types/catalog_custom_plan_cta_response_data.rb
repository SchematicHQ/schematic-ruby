# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogCustomPlanCtaResponseData < Internal::Types::Model
      field :cta_text, -> { String }, optional: true, nullable: false

      field :cta_url, -> { String }, optional: true, nullable: false

      field :price_text, -> { String }, optional: true, nullable: false
    end
  end
end
