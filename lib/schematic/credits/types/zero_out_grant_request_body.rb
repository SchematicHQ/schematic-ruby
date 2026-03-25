# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ZeroOutGrantRequestBody < Internal::Types::Model
        field :grant_id, -> { String }, optional: false, nullable: false
        field :reason, -> { Schematic::Types::BillingCreditGrantZeroedOutReason }, optional: true, nullable: false
      end
    end
  end
end
