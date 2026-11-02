# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class OnboardingRoadmapView < Internal::Types::Model
      field :published_at, -> { String }, optional: true, nullable: false

      field :slug, -> { String }, optional: false, nullable: false
    end
  end
end
