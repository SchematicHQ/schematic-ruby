# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UpdateCompanyTrialRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false

        field :end_behavior, -> { Schematic::Types::BillingSubscriptionTrialEndSetting }, optional: true, nullable: false

        field :trial_end, -> { String }, optional: true, nullable: false
      end
    end
  end
end
