# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class UpdateOnboardingStateRequestBody < Internal::Types::Model
        field :path, -> { Schematic::Types::OnboardingPath }, optional: true, nullable: false

        field :pricing_page_url, -> { String }, optional: true, nullable: false

        field :track, -> { Schematic::Types::OnboardingTrack }, optional: true, nullable: false

        field :website_url, -> { String }, optional: true, nullable: false
      end
    end
  end
end
