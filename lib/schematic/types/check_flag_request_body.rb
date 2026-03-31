# frozen_string_literal: true

module Schematic
  module Types
    class CheckFlagRequestBody < Internal::Types::Model
      field :company, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :user, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
    end
  end
end
