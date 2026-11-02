# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      # Input parameters
      class GetActiveCompanySubscriptionParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false

        field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
