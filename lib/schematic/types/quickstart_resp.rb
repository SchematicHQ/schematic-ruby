# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class QuickstartResp < Internal::Types::Model
      field :ok, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
