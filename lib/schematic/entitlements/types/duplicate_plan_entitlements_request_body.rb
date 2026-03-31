# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class DuplicatePlanEntitlementsRequestBody < Internal::Types::Model
        field :source_plan_id, -> { String }, optional: false, nullable: false
        field :target_plan_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
