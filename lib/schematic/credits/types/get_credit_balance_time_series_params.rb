# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      # Input parameters
      class GetCreditBalanceTimeSeriesParams < Internal::Types::Model
        field :billing_credit_id, -> { String }, optional: true, nullable: false

        field :company_id, -> { String }, optional: true, nullable: false

        field :end_time, -> { String }, optional: true, nullable: false

        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
