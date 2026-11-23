# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class ZuoraIntegrationConfig < Internal::Types::Model
      field :base_url, -> { String }, optional: true, nullable: false

      field :client_id, -> { String }, optional: true, nullable: false
    end
  end
end
