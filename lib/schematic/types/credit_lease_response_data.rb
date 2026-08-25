# frozen_string_literal: true

module Schematic
  module Types
    class CreditLeaseResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :credit_type_id, -> { String }, optional: false, nullable: false

      field :expires_at, -> { String }, optional: false, nullable: false

      field :granted_amount, -> { Integer }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :released_at, -> { String }, optional: true, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
