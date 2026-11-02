# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class StripeSandboxKeysResponseData < Internal::Types::Model
      field :mcp, -> { String }, optional: false, nullable: false

      field :publishable, -> { String }, optional: false, nullable: false

      field :secret, -> { String }, optional: false, nullable: false
    end
  end
end
