# frozen_string_literal: true

module Schematic
  module Types
    class InsightsSummaryResponseData < Internal::Types::Model
      field :active_credits, -> { Integer }, optional: false, nullable: false
      field :mrr, -> { Internal::Types::Array[Schematic::Types::MrrResponseData] }, optional: false, nullable: false
      field :paid_companies, -> { Integer }, optional: false, nullable: false
      field :total_companies, -> { Integer }, optional: false, nullable: false
      field :total_features, -> { Integer }, optional: false, nullable: false
      field :total_plans, -> { Integer }, optional: false, nullable: false
    end
  end
end
