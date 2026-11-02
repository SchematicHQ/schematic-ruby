# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CustomPlanConfig < Internal::Types::Model
      field :cta_text, -> { String }, optional: false, nullable: false

      field :cta_web_site, -> { String }, optional: false, nullable: false

      field :price_text, -> { String }, optional: false, nullable: false
    end
  end
end
