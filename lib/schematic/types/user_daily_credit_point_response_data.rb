# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class UserDailyCreditPointResponseData < Internal::Types::Model
      field :credits_used, -> { Float }, optional: false, nullable: false

      field :date, -> { String }, optional: false, nullable: false
    end
  end
end
