# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineSubscription < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :period_end, -> { String }, optional: false, nullable: false
      field :period_start, -> { String }, optional: false, nullable: false
    end
  end
end
