# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class UpdateAddOnRequestBody < Internal::Types::Model
      field :add_on_id, -> { String }, optional: false, nullable: false

      field :price_id, -> { String }, optional: false, nullable: false
    end
  end
end
