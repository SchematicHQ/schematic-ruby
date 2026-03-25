# frozen_string_literal: true

module Schematic
  module Types
    class CreditsAutoTopupCreditSummary < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
