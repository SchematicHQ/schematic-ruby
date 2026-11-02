# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditsInPlan < Internal::Types::Model
      field :credit_id, -> { String }, optional: false, nullable: false

      field :visible, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
