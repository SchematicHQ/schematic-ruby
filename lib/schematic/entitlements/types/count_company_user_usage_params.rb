# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class CountCompanyUserUsageParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false

        field :end_time, -> { String }, optional: true, nullable: false

        field :feature_id, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :metric, -> { Schematic::Types::UserUsageMetric }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
