# frozen_string_literal: true

module Schematic
  module Types
    class FlagCheckReservationResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :consumption_rate, -> { Integer }, optional: false, nullable: false

      field :credit_type_id, -> { String }, optional: false, nullable: false

      field :credits_reserved, -> { Integer }, optional: false, nullable: false

      field :event_subtype, -> { String }, optional: true, nullable: false

      field :expires_at, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :quantity_reserved, -> { Integer }, optional: false, nullable: false
    end
  end
end
