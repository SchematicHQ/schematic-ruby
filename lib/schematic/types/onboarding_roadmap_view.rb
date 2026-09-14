# frozen_string_literal: true

module Schematic
  module Types
    class OnboardingRoadmapView < Internal::Types::Model
      field :published_at, -> { String }, optional: true, nullable: false

      field :slug, -> { String }, optional: false, nullable: false
    end
  end
end
