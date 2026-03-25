# frozen_string_literal: true

module Schematic
  module Types
    class WebFeatureUsageWebhookOutput < Internal::Types::Model
      field :allocation, -> { Integer }, optional: true, nullable: false, api_name: "Allocation"
      field :credit_usage, -> { Schematic::Types::CreditUsage }, optional: true, nullable: false, api_name: "CreditUsage"
      field :entitlement, -> { String }, optional: false, nullable: false, api_name: "Entitlement"
      field :feature, -> { Schematic::Types::FeatureView }, optional: true, nullable: false, api_name: "Feature"
      field :metric_reset_at, -> { String }, optional: true, nullable: false, api_name: "MetricResetAt"
      field :usage, -> { Integer }, optional: true, nullable: false, api_name: "Usage"
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
    end
  end
end
