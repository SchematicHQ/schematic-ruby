# frozen_string_literal: true

module Schematic
  module Types
    class BillingNativeSubscriptionChangeResponseData < Internal::Types::Model
      field :action, -> { Schematic::Types::SubscriptionChangeAction }, optional: false, nullable: false

      field :effective_at, -> { String }, optional: false, nullable: false

      field :line, -> { Schematic::Types::BillingNativeSubscriptionLineResponseData }, optional: true, nullable: false

      field :replaces, -> { Schematic::Types::BillingNativeSubscriptionLineResponseData }, optional: true, nullable: false
    end
  end
end
