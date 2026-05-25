# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ExtendCreditLeaseRequestBody < Internal::Types::Model
        field :lease_id, -> { String }, optional: false, nullable: false
        field :additional_amount, -> { Integer }, optional: false, nullable: false
        field :expires_at, -> { String }, optional: true, nullable: false
      end
    end
  end
end
