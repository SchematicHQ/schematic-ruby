# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class TopFeatureByUsageResponseData < Internal::Types::Model
      field :change_pct, -> { Float }, optional: true, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :feature_name, -> { String }, optional: false, nullable: false

      field :plural_name, -> { String }, optional: true, nullable: false

      field :prior_usage, -> { Integer }, optional: false, nullable: false

      field :usage, -> { Integer }, optional: false, nullable: false
    end
  end
end
