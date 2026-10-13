# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCreditPostpaidConfig < Internal::Types::Model
      field :overdraft_limit, -> { Float }, optional: true, nullable: false
    end
  end
end
