# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class ListCompanyOverridesParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :feature_id, -> { String }, optional: true, nullable: false
        field :feature_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :without_expired, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
