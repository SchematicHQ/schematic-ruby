# frozen_string_literal: true

module Schematic
  module Types
    class CompanyCreditBalance < Internal::Types::Model
      field :overdraft_limit, -> { Float }, optional: true, nullable: false

      field :postpaid, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :remaining, -> { Float }, optional: false, nullable: false

      field :reserved, -> { Float }, optional: false, nullable: false

      field :settled, -> { Float }, optional: false, nullable: false
    end
  end
end
