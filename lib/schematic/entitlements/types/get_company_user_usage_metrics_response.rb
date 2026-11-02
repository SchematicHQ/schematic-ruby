# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class GetCompanyUserUsageMetricsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyUserUsageMetricsResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::GetCompanyUserUsageMetricsParams }, optional: false, nullable: false
      end
    end
  end
end
