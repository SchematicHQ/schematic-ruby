# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Events
    module Types
      class CreateAccountInferenceCostRateResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::AccountInferenceCostRateResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
