# frozen_string_literal: true

module Schematic
  module Types
    class CreditTriggerConfig < Internal::Types::Model
      field :credit_id, -> { String }, optional: false, nullable: false
    end
  end
end
