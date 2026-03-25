# frozen_string_literal: true

module Schematic
  module Types
    class CreditsAutoTopupRetryFailure < Internal::Types::Model
      field :company, -> { Schematic::Types::CreditsAutoTopupCompanySummary }, optional: true, nullable: false
      field :consecutive_failures, -> { Integer }, optional: false, nullable: false
      field :credit, -> { Schematic::Types::CreditsAutoTopupCreditSummary }, optional: true, nullable: false
      field :last_error_message, -> { String }, optional: true, nullable: false
      field :stripe_error_code, -> { String }, optional: true, nullable: false
    end
  end
end
