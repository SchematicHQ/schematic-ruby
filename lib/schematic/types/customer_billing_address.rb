# frozen_string_literal: true

module Schematic
  module Types
    class CustomerBillingAddress < Internal::Types::Model
      field :city, -> { String }, optional: false, nullable: false
      field :country, -> { String }, optional: false, nullable: false
      field :line_1, -> { String }, optional: false, nullable: false, api_name: "line1"
      field :line_2, -> { String }, optional: false, nullable: false, api_name: "line2"
      field :postal_code, -> { String }, optional: false, nullable: false
      field :state, -> { String }, optional: false, nullable: false
    end
  end
end
