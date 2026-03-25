# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class UpdateCreditBundleDetailsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::BillingCreditBundleResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
