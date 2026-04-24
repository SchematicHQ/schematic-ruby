# frozen_string_literal: true

module Schematic
  module Types
    class FeatureCompanyUserResponseData < Internal::Types::Model
      field :access, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :allocation, -> { Integer }, optional: true, nullable: false
      field :allocation_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
      field :entitlement_id, -> { String }, optional: false, nullable: false
      field :entitlement_type, -> { Schematic::Types::EntitlementType }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureDetailResponseData }, optional: true, nullable: false
      field :metric_reset_at, -> { String }, optional: true, nullable: false
      field :month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false
      field :period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false
      field :plan, -> { Schematic::Types::PlanResponseData }, optional: true, nullable: false
      field :usage, -> { Integer }, optional: true, nullable: false
      field :user, -> { Schematic::Types::UserResponseData }, optional: true, nullable: false
    end
  end
end
