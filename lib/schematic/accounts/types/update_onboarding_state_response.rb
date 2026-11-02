# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Accounts
    module Types
      class UpdateOnboardingStateResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::GetOnboardingStateResp }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
