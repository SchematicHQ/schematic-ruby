# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class AcquireCreditLeaseRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :credit_type_id, -> { String }, optional: false, nullable: false
        field :expires_at, -> { String }, optional: true, nullable: false
        field :requested_amount, -> { Integer }, optional: false, nullable: false
      end
    end
  end
end
