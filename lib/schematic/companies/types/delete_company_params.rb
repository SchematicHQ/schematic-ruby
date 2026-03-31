# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class DeleteCompanyParams < Internal::Types::Model
        field :cancel_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :prorate, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
