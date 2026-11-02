# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanGroupBundleOrder < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false, api_name: "bundleId"
    end
  end
end
