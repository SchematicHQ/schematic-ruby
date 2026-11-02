# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EntitlementTriggerConfig < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false
    end
  end
end
