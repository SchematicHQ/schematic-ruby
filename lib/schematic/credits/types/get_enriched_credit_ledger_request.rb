# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class GetEnrichedCreditLedgerRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :billing_credit_id, -> { String }, optional: true, nullable: false
        field :feature_id, -> { String }, optional: true, nullable: false
        field :period, -> { Schematic::Types::CreditLedgerPeriod }, optional: false, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
        field :end_time, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
