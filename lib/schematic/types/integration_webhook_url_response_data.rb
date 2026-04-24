# frozen_string_literal: true

module Schematic
  module Types
    class IntegrationWebhookUrlResponseData < Internal::Types::Model
      field :type, -> { Schematic::Types::IntegrationType }, optional: false, nullable: false
      field :url, -> { String }, optional: false, nullable: false
    end
  end
end
