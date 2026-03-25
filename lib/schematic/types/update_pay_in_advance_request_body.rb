# frozen_string_literal: true

module Schematic
  module Types
    class UpdatePayInAdvanceRequestBody < Internal::Types::Model
      field :price_id, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
