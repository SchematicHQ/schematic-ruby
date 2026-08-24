# frozen_string_literal: true

module Schematic
  module Types
    class OnboardingMilestoneView < Internal::Types::Model
      field :id, -> { Schematic::Types::OnboardingMilestone }, optional: false, nullable: false

      field :missing, -> { Internal::Types::Array[Schematic::Types::OnboardingRequirement] }, optional: false, nullable: false

      field :progress, -> { Integer }, optional: false, nullable: false

      field :reached_at, -> { String }, optional: true, nullable: false
    end
  end
end
