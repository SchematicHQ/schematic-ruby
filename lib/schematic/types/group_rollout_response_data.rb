# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutResponseData < Internal::Types::Model
      field :companies, -> { Internal::Types::Array[Schematic::Types::GroupRolloutCompanyResultResponseData] }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :from_plan_version_id, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :payer_company_id, -> { String }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false

      field :to_plan_version_id, -> { String }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
