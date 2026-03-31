# frozen_string_literal: true

module Schematic
  module Types
    class CreditTransferView < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :direction, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :related_grant_id, -> { String }, optional: false, nullable: false
    end
  end
end
