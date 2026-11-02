# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class RulesDetailResponseData < Internal::Types::Model
      field :flag, -> { Schematic::Types::FlagResponseData }, optional: true, nullable: false

      field :rules, -> { Internal::Types::Array[Schematic::Types::RuleDetailResponseData] }, optional: false, nullable: false
    end
  end
end
