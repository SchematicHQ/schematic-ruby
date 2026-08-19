# frozen_string_literal: true

module Schematic
  module Types
    class OnboardingRequirementView < Internal::Types::Model
      field :blocked_by, -> { Internal::Types::Array[Schematic::Types::OnboardingRequirement] }, optional: true, nullable: false
      field :id, -> { Schematic::Types::OnboardingRequirement }, optional: false, nullable: false
      field :satisfied_by, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::OnboardingRequirementStatus }, optional: false, nullable: false
    end
  end
end
