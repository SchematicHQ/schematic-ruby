# frozen_string_literal: true

module Schematic
  module Types
    class CreditsAutoTopupHardFailure < Internal::Types::Model
      field :company, -> { Schematic::Types::CreditsAutoTopupCompanySummary }, optional: true, nullable: false
      field :credit, -> { Schematic::Types::CreditsAutoTopupCreditSummary }, optional: true, nullable: false
      field :error_message, -> { String }, optional: true, nullable: false
      field :stripe_error_code, -> { String }, optional: true, nullable: false
    end
  end
end
