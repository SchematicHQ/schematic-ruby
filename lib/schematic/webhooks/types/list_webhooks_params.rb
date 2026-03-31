# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      # Input parameters
      class ListWebhooksParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
