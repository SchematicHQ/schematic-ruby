# frozen_string_literal: true

module Schematic
  module Types
    class UpdateAutoTopupOverrideRequestBody < Internal::Types::Model
      field :auto_topup_amount, -> { Integer }, optional: true, nullable: false
      field :auto_topup_enabled, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :auto_topup_threshold_credits, -> { Integer }, optional: true, nullable: false
      field :plan_credit_grant_id, -> { String }, optional: false, nullable: false
    end
  end
end
