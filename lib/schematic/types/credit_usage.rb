# frozen_string_literal: true

module Schematic
  module Types
    class CreditUsage < Internal::Types::Model
      field :credit_consumption_rate, -> { Float }, optional: true, nullable: false

      field :credit_grant_counts, -> { Internal::Types::Hash[String, Float] }, optional: true, nullable: false

      field :credit_grant_details, -> { Internal::Types::Array[Schematic::Types::CreditGrantDetail] }, optional: true, nullable: false

      field :credit_remaining, -> { Float }, optional: true, nullable: false

      field :credit_total, -> { Float }, optional: true, nullable: false

      field :credit_type_icon, -> { String }, optional: true, nullable: false

      field :credit_type_name, -> { String }, optional: true, nullable: false

      field :credit_used, -> { Float }, optional: true, nullable: false

      field :usage_aggregation, -> { Schematic::Types::CreditUsageAggregation }, optional: true, nullable: false
    end
  end
end
