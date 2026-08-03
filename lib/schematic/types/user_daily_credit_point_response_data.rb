# frozen_string_literal: true

module Schematic
  module Types
    class UserDailyCreditPointResponseData < Internal::Types::Model
      field :credits_used, -> { Integer }, optional: false, nullable: false
      field :date, -> { String }, optional: false, nullable: false
    end
  end
end
