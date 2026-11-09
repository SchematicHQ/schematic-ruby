# frozen_string_literal: true

module Schematic
  module Customplangrouprollouts
    module Types
      class StartGroupRolloutRequestBody < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false

        field :excluded_company_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false

        field :from_plan_version_id, -> { String }, optional: true, nullable: false

        field :to_plan_version_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
