# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCreditPostpaidConfig < Internal::Types::Model
      field :overdraft_limit, -> { Integer }, optional: true, nullable: false
    end
  end
end
