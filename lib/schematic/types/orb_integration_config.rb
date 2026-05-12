# frozen_string_literal: true

module Schematic
  module Types
    class OrbIntegrationConfig < Internal::Types::Model
      field :external_customer_id_key, -> { String }, optional: true, nullable: false
    end
  end
end
