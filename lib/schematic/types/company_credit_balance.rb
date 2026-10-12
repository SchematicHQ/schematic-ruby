# frozen_string_literal: true

module Schematic
  module Types
    class CompanyCreditBalance < Internal::Types::Model
      field :remaining, -> { Float }, optional: false, nullable: false

      field :reserved, -> { Float }, optional: false, nullable: false

      field :settled, -> { Float }, optional: false, nullable: false
    end
  end
end
