# frozen_string_literal: true

module Schematic
  module Types
    class PlanGroupBundleOrder < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false, api_name: "bundleId"
    end
  end
end
