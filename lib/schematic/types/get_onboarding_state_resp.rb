# frozen_string_literal: true

module Schematic
  module Types
    class GetOnboardingStateResp < Internal::Types::Model
      field :agent_connected_at, -> { String }, optional: true, nullable: false

      field :dismissed_at, -> { String }, optional: true, nullable: false

      field :environment_id, -> { String }, optional: true, nullable: false

      field :milestones, -> { Internal::Types::Array[Schematic::Types::OnboardingMilestoneView] }, optional: false, nullable: false

      field :path, -> { Schematic::Types::OnboardingPath }, optional: true, nullable: false

      field :pricing_page_url, -> { String }, optional: true, nullable: false

      field :requirements, -> { Internal::Types::Array[Schematic::Types::OnboardingRequirementView] }, optional: false, nullable: false

      field :stripe_import, -> { Schematic::Types::OnboardingStripeImport }, optional: true, nullable: false

      field :suggested_next, -> { Internal::Types::Array[Schematic::Types::OnboardingRequirement] }, optional: false, nullable: false

      field :track, -> { Schematic::Types::OnboardingTrack }, optional: true, nullable: false

      field :website_url, -> { String }, optional: true, nullable: false
    end
  end
end
