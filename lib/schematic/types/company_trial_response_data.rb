# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyTrialResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :end_behavior, -> { Schematic::Types::BillingSubscriptionTrialEndSetting }, optional: false, nullable: false

      field :ended_at, -> { String }, optional: true, nullable: false

      field :ends_at, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false

      field :plan_version_id, -> { String }, optional: true, nullable: false

      field :source, -> { Schematic::Types::TrialSource }, optional: false, nullable: false

      field :started_at, -> { String }, optional: false, nullable: false

      field :status, -> { Schematic::Types::CompanyTrialStatus }, optional: false, nullable: false

      field :subscription_id, -> { String }, optional: true, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
