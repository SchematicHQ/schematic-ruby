# frozen_string_literal: true

module Schematic
  module Types
    class CreditsAutoTopupSuccess < Internal::Types::Model
      field :company, -> { Schematic::Types::CreditsAutoTopupCompanySummary }, optional: true, nullable: false
      field :credit, -> { Schematic::Types::CreditsAutoTopupCreditSummary }, optional: true, nullable: false
      field :grant_id, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
