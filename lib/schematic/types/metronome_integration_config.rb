# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class MetronomeIntegrationConfig < Internal::Types::Model
      field :external_customer_id_key, -> { String }, optional: true, nullable: false
    end
  end
end
