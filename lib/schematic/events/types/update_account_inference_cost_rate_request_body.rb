# frozen_string_literal: true

module Schematic
  module Events
    module Types
      class UpdateAccountInferenceCostRateRequestBody < Internal::Types::Model
        field :inference_rate_sheet_id, -> { String }, optional: false, nullable: false

        field :rates, -> { Internal::Types::Hash[String, Float] }, optional: false, nullable: false
      end
    end
  end
end
