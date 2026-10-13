# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetCreditBalanceTimeSeriesRequest < Internal::Types::Model
        field :billing_credit_id, -> { String }, optional: false, nullable: false

        field :company_id, -> { String }, optional: false, nullable: false

        field :end_time, -> { String }, optional: false, nullable: false

        field :start_time, -> { String }, optional: false, nullable: false
      end
    end
  end
end
