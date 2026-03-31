# frozen_string_literal: true

module Schematic
  module Types
    class StripeEmbedInfo < Internal::Types::Model
      field :account_id, -> { String }, optional: true, nullable: false
      field :publishable_key, -> { String }, optional: true, nullable: false
      field :schematic_publishable_key, -> { String }, optional: false, nullable: false
      field :setup_intent_client_secret, -> { String }, optional: true, nullable: false
    end
  end
end
