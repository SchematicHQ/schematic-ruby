# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class UpdateFlagRulesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::RulesDetailResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
