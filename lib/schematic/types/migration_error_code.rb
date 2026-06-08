# frozen_string_literal: true

module Schematic
  module Types
    module MigrationErrorCode
      extend Schematic::Internal::Types::Enum

      AMBIGUOUS_SUBSCRIPTION_ITEM = "ambiguous_subscription_item"
      MULTIPLE_SUBSCRIPTIONS = "multiple_subscriptions"
      NO_PRICE_FOR_INTERVAL = "no_price_for_interval"
      NOT_ON_ORIGIN_VERSION = "not_on_origin_version"
      OPERATION_ITEM_NOT_FOUND = "operation_item_not_found"
      PERMANENT_CONFIG = "permanent_config"
      PERMANENT_DECLINE = "permanent_decline"
      TRANSIENT_DECLINE = "transient_decline"
      TRANSIENT_INFRA = "transient_infra"
      TRANSIENT_STRIPE = "transient_stripe"
      UNKNOWN = "unknown"
      WOULD_LEAVE_EMPTY_SUBSCRIPTION = "would_leave_empty_subscription"
    end
  end
end
