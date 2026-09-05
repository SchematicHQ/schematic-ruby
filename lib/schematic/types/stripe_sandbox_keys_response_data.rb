# frozen_string_literal: true

module Schematic
  module Types
    class StripeSandboxKeysResponseData < Internal::Types::Model
      field :mcp, -> { String }, optional: false, nullable: false

      field :publishable, -> { String }, optional: false, nullable: false

      field :secret, -> { String }, optional: false, nullable: false
    end
  end
end
