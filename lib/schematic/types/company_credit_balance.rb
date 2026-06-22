# frozen_string_literal: true

module Schematic
  module Types
    class CompanyCreditBalance < Internal::Types::Model
      field :remaining, -> { Integer }, optional: false, nullable: false
      field :reserved, -> { Integer }, optional: false, nullable: false
      field :settled, -> { Integer }, optional: false, nullable: false
    end
  end
end
