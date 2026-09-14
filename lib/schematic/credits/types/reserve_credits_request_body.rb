# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ReserveCreditsRequestBody < Internal::Types::Model
        field :amount, -> { Integer }, optional: false, nullable: false

        field :company_id, -> { String }, optional: false, nullable: false

        field :credit_type_id, -> { String }, optional: false, nullable: false

        field :expires_at, -> { String }, optional: true, nullable: false

        field :idempotency_key, -> { String }, optional: true, nullable: false
      end
    end
  end
end
