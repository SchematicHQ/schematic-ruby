# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditTriggerConfig < Internal::Types::Model
      field :credit_id, -> { String }, optional: false, nullable: false
    end
  end
end
