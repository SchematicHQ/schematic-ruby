# frozen_string_literal: true

module Schematic
  module Types
    class CreditSpendPolicy < Internal::Types::Model
      field :consumed, -> { Integer }, optional: true, nullable: false

      field :credit_id, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :kind, -> { String }, optional: false, nullable: false

      field :label, -> { String }, optional: true, nullable: false

      field :limit, -> { Integer }, optional: false, nullable: false

      field :resets_at, -> { String }, optional: true, nullable: false

      field :scope, -> { Schematic::Types::CreditSpendPolicyScope }, optional: false, nullable: false

      field :window, -> { Schematic::Types::CreditSpendWindow }, optional: true, nullable: false
    end
  end
end
