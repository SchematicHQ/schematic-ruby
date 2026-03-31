# frozen_string_literal: true

module Schematic
  module Webhooks
    module Types
      class CountWebhooksResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Webhooks::Types::CountWebhooksParams }, optional: false, nullable: false
      end
    end
  end
end
