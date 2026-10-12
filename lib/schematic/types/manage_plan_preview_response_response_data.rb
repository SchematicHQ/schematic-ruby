# frozen_string_literal: true

module Schematic
  module Types
    class ManagePlanPreviewResponseResponseData < Internal::Types::Model
      field :problems, -> { Internal::Types::Array[Schematic::Types::CheckoutProblemResponseData] }, optional: false, nullable: false

      field :subscription_change_preview, -> { Schematic::Types::PreviewSubscriptionChangeResponseData }, optional: true, nullable: false
    end
  end
end
