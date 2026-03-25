# frozen_string_literal: true

module Schematic
  module Types
    class EntitlementTriggerConfig < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false
    end
  end
end
