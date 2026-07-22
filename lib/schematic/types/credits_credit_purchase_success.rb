# frozen_string_literal: true

module Schematic
  module Types
    class CreditsCreditPurchaseSuccess < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false
      field :bundle_name, -> { String }, optional: false, nullable: false
      field :company, -> { Schematic::Types::CreditsWebhookCompanySummary }, optional: true, nullable: false
      field :credit, -> { Schematic::Types::CreditsWebhookCreditSummary }, optional: true, nullable: false
      field :grant_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
