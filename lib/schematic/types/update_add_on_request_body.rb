# frozen_string_literal: true

module Schematic
  module Types
    class UpdateAddOnRequestBody < Internal::Types::Model
      field :add_on_id, -> { String }, optional: false, nullable: false
      field :price_id, -> { String }, optional: false, nullable: false
    end
  end
end
