# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      # Input parameters
      class CountBillingCreditsGrantsParams < Internal::Types::Model
        field :credit_id, -> { String }, optional: true, nullable: false

        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
